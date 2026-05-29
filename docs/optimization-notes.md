# Optimization notes

Engineering notes on block-codec performance work: what was tried, what was
kept, and — importantly — what was reverted and why. The goal is to save the
next person from re-running experiments that have already been shown not to pay
off, and to record the measurement pitfalls on the hardware used.

## Measurement caveat (read this first)

Benchmark results in this repo were collected on a Windows 11 laptop
(Sapphire Rapids, `target-cpu=native`). That environment has a **~±10–15 %
run-to-run noise floor**:

- **Thermal drift.** Over a long bench session the CPU throttles, so a baseline
  captured cold makes everything measured later look slower. A change that
  touches *no* code on a path can appear to "regress" 15 % purely from drift.
- **Timer resolution.** `std::time::Instant` resolves to ~100 ns here, so
  per-iteration `min` timing of sub-µs work is quantized and unreliable. For
  tiny workloads, time the **total** wall-clock over many iterations and divide,
  rather than taking a per-call minimum.

**Consequence:** criterion's `--save-baseline` / `--baseline` cross-run compare
is only meaningful when both runs share a thermal window — otherwise sub-15 %
deltas are not trustworthy. What *does* work reliably here: take the **minimum
over many iterations of a large (≈10 ms+) workload**, run the A and B builds
back-to-back, and always run an **A/A test** (same build twice) first to measure
the floor. With that method the A/A floor is **~0.1 % on min** (drift only ever
*adds* time, so the minimum reflects true compute). For deterministic, noise-free
claims about *allocation* changes, count allocations with a counting
`#[global_allocator]` rather than timing at all.

## Where the L1 encoder spends its time (profile)

`samply` profile (40 134 samples, single-threaded `Level::Fastest` encode of
1 MiB of expanded Twain, big path), attributed to the inlined inner loops:

| % of total | region |
|-----------:|--------|
| **88.7 %** | per-position **search loop** |
| 9.3 %      | emit / tail (`emit_*` calls, `emitRemainder`) |
| 1.9 %      | match extension (`load64`-XOR `tzcnt` loops) |

The search loop is **memory- and branch-bound, not arithmetic-bound**: the
128 KiB `[u32]` hash table is L2-resident, so its probes (~20%) plus the
candidate `src` compares (~21%) plus the stall/mispredict skid on loop-top
instructions account for ~60%+ of total; the three `hash6` multiplies are only
~8% (LLVM strength-reduces each to one `imul`). Match extension is negligible
for text. Full source-vs-assembly annotation:
[`l1-hot-loop-profile.md`](l1-hot-loop-profile.md).

The most promising further optimization is therefore *latency-hiding*
(software-prefetch the next iteration's hash slots), not instruction selection
— which is also why upstream Go MinLZ hand-writes this loop in assembly.

## Changes tried (2026-05)

Three safe-Rust changes were evaluated with criterion A/B plus a focused
decode probe. `target-cpu=native` was already in effect, so LLVM already had
the full AVX-512 ISA.

### 1. L1 thread-local hash table — **KEPT**

`block/encode_l1.rs::encode_block_big` previously allocated and zeroed a 128 KiB
`vec![0u32; 32768]` on every call. It now lends a per-thread buffer via a
`thread_local!` + `with_table_big` helper and an inner `encode_inner_big`,
mirroring the pattern already used by L2 (`with_l_table_big`) and L3
(`with_tables`).

Correct (full test suite passes, output byte-identical) and consistent with the
codebase — L1 was the only encoder still allocating per call.

Measured benefit (see methodology above):

- **Allocation traffic — eliminated (deterministic, counting allocator).** Over
  1000 big-path encodes of a 256 KiB block: the per-call 128 KiB table
  allocations drop **1000 → 0** (allocated once per thread, then reused), and
  total allocation traffic drops from **~125 MiB → ~1 KiB**.
- **MT encode wall-time** (32 MiB, 96 KiB blocks, 24 threads; min/median of 40,
  A/A floor ~0.1 % min):
  - *Best case (min): unchanged* (~2595 MB/s) — an uncontended recycled 128 KiB
    alloc is cheap.
  - *Typical (median): ~4 % faster and much tighter* (~2500 vs ~2400 MB/s).
    Without reuse, concurrent 128 KiB allocs across workers contend on the
    allocator; thread-local reuse removes that. (The without-change *min* is not
    elevated, so this is contention variance, not thermal drift.)
- **Workload-dependent.** The 96 KiB block size above *amplifies* the effect
  (table alloc is a large fraction of each block's work). Single-threaded, or
  with the default 2 MiB blocks, the alloc is a tiny fraction and there is no
  contention → wall-time difference is within noise. The allocation-traffic
  reduction is constant regardless; that is the change's primary, always-true
  benefit (allocator pressure / fragmentation in long-running and MT services).

### 2. Fat LTO — **REVERTED**

Switching `[profile.release] lto = "thin"` → `"fat"` produced no reliable
improvement: byte-identical decode code swung both −16 % and +14 % across cases
(i.e. pure noise), while build time roughly doubled. The hot loops are already
within-crate and `#[inline]`, leaving little for cross-crate LTO to do. Kept at
`"thin"`.

### 3. Chunked overlap copy — **REVERTED**

`block/decode.rs::forward_copy_ptr` (the LZ77 overlap path, used when
`offset <= length`) was rewritten to copy `u64` chunks when `offset >= 8`,
falling back to the byte loop for offsets 1–7. It was correct and **miri-clean**
(validated via `miri_decoder_unsafe_paths`).

Reverted anyway, because:

1. **The path is almost never produced by this codec's encoder.** The L1 encoder
   compresses offset-1 RLE and `offset >= 64` *disjoint* matches; it stores
   tight-period data (period 4–64) uncompressed (see observation below). So
   `offset >= 8` **overlap** copies (`offset <= length`) essentially never occur
   in this codec's own output.
2. **No test coverage and no measurable benefit.** Every overlap test uses
   offsets 1–7 (the byte loop); the one offset-26 fixture has `offset > length`,
   so it takes the *disjoint* memcpy branch, not `forward_copy_ptr`.
3. It added a 16-byte overshoot-store contract to carefully-audited `unsafe`
   code. Not worth the complexity for an unhit, untested path.

A chunked overlap copy would still help *foreign* or adversarial overlap-heavy
blocks (valid MinLZ that other encoders could emit). If that ever matters,
re-add it **with** a dedicated test that constructs a block with
`offset >= 8 && offset <= length` and a length large enough to measure above the
noise floor.

## Encoder observation (pre-existing; not a regression)

The L1 `encode()` block API stores tight-period inputs (period 4, 16, 64 …)
**uncompressed** — only offset-1 RLE and `offset >= 64` matches compress. This
predates the work above (confirmed against a pristine checkout). Worth a
separate look if compression ratio on periodic/structured data matters.
