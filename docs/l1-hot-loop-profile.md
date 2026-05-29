# L1 encoder hot loop — annotated profile

Where the L1 (`Level::Fastest`) encoder spends its time, with the source
annotated against the generated assembly and a sampled profile.

## How this was measured

- **Workload:** single-threaded `encode(.., Level::Fastest)` of 1 MiB of
  expanded Twain (`>` 64 KiB ⇒ the `encode_inner_big` path), in a tight loop.
- **Profiler:** `samply` @ 4 kHz, **40 134 stack samples**.
- **Attribution:** the whole encoder inlines into one symbol
  (`minlz::block::encode_l1::encode_block`), so samples were mapped to
  instructions via `llvm-objdump` and bucketed by instruction signature
  (`movabsq $0xcf1bbcdcbf9b`+`imul`+`shrq $49` = hashing; `movl …(%rsi,…,4)`
  = the 128 KiB table; `tzcnt` = match extension; `call` = emit).
- Build: `--release`, `target-cpu=native` (Sapphire Rapids, AVX-512 available).

Caveat: instruction-level attribution has sampling **skid** (a stall on a load
is often charged to a consumer a few instructions later), so the fine split is
approximate; the macro split is solid.

## Macro split

| % of total | region |
|-----------:|--------|
| **88.7 %** | per-position **search loop** (`encode_inner_big` inner `loop`) |
| 9.3 %      | emit / tail (`emit_literal` / `emit_copy` calls, `emitRemainder`) |
| 1.9 %      | **match extension** (the `load64`-XOR `tzcnt` loops) |
| ~0 %       | everything else |

For moderately-compressible text, the **search loop dominates** — match
extension is negligible. On highly-compressible data the `tzcnt` share rises.

## Annotated search loop (`crates/minlz/src/block/encode_l1.rs`)

```rust
loop {
    // ┌─ search back-edge lands here. `0xffa0 ≈ 4.9%` — load-use stall:
    // │  the table base pointer is reloaded from the stack (register
    // │  pressure: the whole encoder inlined into one fn spills invariants).
    let next_s = s + ((s - next_emit) >> SKIP_LOG) + 4;  // sub; shr $6; lea
    if next_s > s_limit { break 'outer; }                // cmp; ja   (exit)

    let min_src_pos = (s + 2).saturating_sub(MAX_COPY3_OFFSET);
                                                         // lea; sub $0x210bff; cmovae
    // ── hashing: ~8% of total across all three hash6 calls ──
    //    hash6(u) = ((u<<16).wrapping_mul(PRIME6)) >> 49, strength-reduced by
    //    LLVM to a single `imul` by the pre-shifted constant (PRIME6<<16):
    let hash0 = hash6(cv,      TABLE_BITS);              // movabs $-0x30e4..; imul; shr $49
    let hash1 = hash6(cv >> 8, TABLE_BITS);              // imul; shr $49     (math is cheap)

    // ── the 128 KiB `[u32; 32768]` table: ~20% of total ──
    //    Random, data-dependent access; the table is far bigger than L1d
    //    (48 KiB) so every probe is an L2 hit (~14 cyc). This is the core cost.
    let c0 = table[hash0] as usize;                      // movl (%rsi,r15,4)  load   1.4%
    let c1 = table[hash1] as usize;                      // movl (%rsi,rdi,4)  load   2.0%
    table[hash0] = s as u32;                             // movl r13d,(%rsi..) store  1.1%
    table[hash1] = (s + 1) as u32;                       // movl r,(%rsi..)    store
    let hash2 = hash6(cv >> 16, TABLE_BITS);             // 0x10059 ≈ 9.5%: and $~0xffff;
                                                         //   movabs $PRIME6; imul; shr $49

    // repeat check (offset +1) — one more src compare + branch
    if prev <= s && ((cv >> 8) as u32) == load32(src, prev) { /* … extend … */ }

    // ── candidate compares: ~21% of total ──
    //    Compare cv against load32(src, c{0,1,2}). The src reads are cheap
    //    (sequential, L1-resident); the cost is the *branch mispredicts* —
    //    whether a position matches is essentially random on real text.
    if c0 >= min_src_pos && (cv as u32)        == load32(src, c0) { … break } // cmp;cmp;je
    let c2 = table[hash2] as usize;                      // movl (%rsi,rbx,4)  table load
    if c1 >= min_src_pos && ((cv >> 8)  as u32) == load32(src, c1) { … break } // 0x10084 ≈ 1.1%
    table[hash2] = (s + 2) as u32;
    if c2 >= min_src_pos && ((cv >> 16) as u32) == load32(src, c2) { … break }

    cv = load64(src, next_s);                            // movq (src,next_s)
    s  = next_s;
}                                                        // jmp back to 0xffa0
```

The **immediate-match loop** further down mirrors this hashing + table-probe
sequence and is also hot — `0x108ef ≈ 10.7%` is its loop-top `lea` (a
branch-target pile-up = mispredict/load-use skid), and `0x107c0 ≈ 1.6%` is its
`load64(src, s-2)`.

The **match-extension** SWAR loop (only ~1.9% here) is already optimal:

```rust
let diff = load64(src, s) ^ load64(src, cand);  // mov; mov; xor
s += (diff.trailing_zeros() as usize) >> 3;     // tzcnt; shr $3; add   (8 bytes/iter)
```

## Conclusions

1. **The encoder is search-loop-bound (~89%), not extension-bound (~2%)** for
   text — the cost is per-position probing, not copying matched runs.
2. **Hashing arithmetic is cheap (~8%).** LLVM strength-reduced the
   `(u<<16)*PRIME6` to a single `imul` per hash and the three are pipelined —
   the multiplies are *not* the bottleneck.
3. **Memory + branches dominate.** Direct 128 KiB-table probes (~20%) and
   candidate `src` compares (~21%), **plus** most of the remaining ~40% is
   stall/mispredict skid landing on loop-top instructions (`0x108ef` 10.7%,
   `0xffa0` 4.9%). Net: **60 %+ of the encoder is memory-access + branch
   behaviour in the search loop.**

### Implication for optimization
Prettier instruction selection buys ~nothing — the loop is **latency-bound on
the L2-resident hash table** and on unpredictable candidate branches. The
levers with real upside are *algorithmic / microarchitectural*:

- **Software prefetch** (`_mm_prefetch`) of the next iteration's hash slots to
  overlap the L2 latency — the single most promising change.
- A **smaller table** that fits L1d (trades match quality for cache residency;
  the ≤64 KiB path already uses a 16 KiB `[u16]` table).
- Fewer probes per position.

This is also why the upstream Go MinLZ ships hand-written `asm_amd64.s` for this
loop: not for better instruction selection, but to hand-schedule prefetch and
register allocation to hide the table latency.
