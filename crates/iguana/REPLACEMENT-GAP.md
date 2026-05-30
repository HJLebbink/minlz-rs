# Iguana → MinLZ replacement gap

What iguana needs before it can replace the MinLZ (LZ77) codec inside MinIO
(AIStor / `eos`). Derived from the actual MinLZ call sites in
`c:\source\minio\eos`, not from the spec.

## SIMD / platform status (read first)

**Iguana's two SIMD paths now cover MinIO's primary fleet (Linux amd64 + arm64).**
The AVX-512 kernels build under **both the Win64 and the SysV/Linux ABI** (the seam
is a `%ifdef IGUANA_SYSV` register shuffle in each `.asm`; `build.rs` defines it on
Linux and NASM picks ELF vs COFF), and aarch64 Linux gets **SVE2** kernels (GAS
`.S`). Off those paths the code runs the **portable scalar** twin (same bytes, lower
throughput). There is still no SSE4.2/AVX2 fallback and no NEON path.

| Target | Acceleration |
|---|---|
| Windows x86-64 + AVX-512 | ✅ AVX-512 (NASM, Win64 ABI) |
| Linux x86-64 + AVX-512 | ✅ AVX-512 (NASM, **SysV ABI** — ported) |
| Linux aarch64 + SVE2 | ✅ SVE2 entropy (ans32 dec/enc) + match finder + **structural decode** (VLA kernel, ~+20% over scalar at VL=128; widens on ≥256-bit cores) |
| macOS (x86-64 / Apple Silicon) | scalar (`build.rs` enables only windows/linux) |
| x86-64 without AVX-512 | scalar (no SSE/AVX2 fallback) |
| aarch64 without SVE2, or non-Linux ARM | scalar |

So MinIO's **Linux amd64** (full AVX-512) and **Linux arm64** (SVE2 entropy + match
finder + structural decode, ~1.0 GiB/s at VL=128) are both accelerated. What remains
is the long tail above, not the whole server fleet.
**Open validation item:** the Win64 path is exercised on the dev box and SVE2 on the
GB10; the **Linux x86-64 / SysV path is wired and builds, but its runtime
differential test on a Linux runner is the remaining check** (the bodies are shared
with Win64, only the ABI seam differs, so the risk is low).

## How MinIO uses MinLZ (the requirement set)

Three consumers with different demands:

| Consumer | File | Mode | Key features |
|---|---|---|---|
| Object data at rest | `cmd/object-api-utils.go` | stream + **detachable index** | level/padding writer, `CloseIndex`, `RemoveIndexHeaders`, `Index.Load/Find`, `RestoreIndexHeaders`, `Reader.Reset`, `Reader.Skip`, `ReaderFallback`, `ReaderIgnoreStreamIdentifier`, pooling |
| Grid RPC | `internal/grid/msg.go` | **block, fastest** | `TryEncode` (give-up), `Decode`, `DecodedLen`, `MaxEncodedLen`, `MaxBlockSize`, `FlagMinLZ` |
| Metacache / replication / stats / logger / untar | several | stream | `WriterBlockSize`, `WriterConcurrency(2)`, `ReaderFallback` |

Iguana exposes today: `iguana_compress/decompress(_simd)`; the `block` module
(`encode`/`decode`/`try_encode`/`decoded_len`/`max_encoded_len`/`MAX_BLOCK_SIZE`);
and `stream::{Writer (incl. `finish_index`), Reader (incl. `fallback`/`skip`),
compress, decompress, SeekReader (incl. `with_index`), Index}`.

## Tier 1 — blockers ✅ DONE

All four are implemented in the `iguana` crate (`stream::Index`, `Reader::fallback`,
`Reader::skip`, the `block` module) and tested in `tests/stream_and_block_api.rs`. The
descriptions below are the original requirements; the **✅** lines record what
satisfies each. (These are API capabilities in iguana's own format — not MinLZ
byte-compatibility, which the port never required.)

### 1. Detachable random-access index

The biggest mismatch. MinIO stores the index **outside the data stream**, in
per-part object metadata (`oi.Parts[].Index`), encrypted/decrypted separately
from the payload.

- Write: `comp.CloseIndex()` → `minlz.RemoveIndexHeaders(idx)` → store in metadata
  (`object-api-utils.go:1131-1132`).
- Read: `minlz.RestoreIndexHeaders(meta)` → `idx.Load(...)` → `idx.Find(partSkip)`
  → `(compOff, uCompOff)` (`object-api-utils.go:538-542`, `:561-565`).

Iguana's index is **appended to the `.igz` tail** and only consumed by
`SeekReader`. We need a *separable* `Index` value: produce it at close **without
embedding it**, serialize it, `Load` it back, `Find(offset) -> (comp, uncomp)`,
plus the header strip/restore helpers. `SeekReader` as-is does not fit, because
in MinIO the data and the index live in different objects.

✅ **`stream::Index`** + `Writer::finish_index() -> (W, Index)` (= `CloseIndex`,
emits no trailer), `Index::to_bytes()`/`Index::load()` (the detached, header-free
metadata form — the strip/restore equivalent), `Index::find(off) -> (comp, uncomp)`,
and `SeekReader::with_index(inner, &index)` (= `Reader.ReadSeeker(index)`) to read a
trailer-less stream with an external index.

### 2. `ReaderFallback(true)` — pass-through of non-codec input

Used in ≥5 places (`object-api-utils.go:648,652`, `metacache-stream.go:252`,
`untar.go:140`, `global_queue_disk.go:240`). If the input is not a valid codec
stream, emit the bytes **verbatim**. This is how MinIO runs one read path over a
mix of compressed and uncompressed objects. Iguana's `Reader` has no fallback
and would error on uncompressed input.

✅ **`Reader::fallback(true)`** — if the input doesn't begin with the `IGZS` magic,
its bytes (including any shorter-than-magic input) are served verbatim.

### 3. Block-codec primitives for grid

Grid RPC is latency-bound and uses *give-up* semantics
(`internal/grid/msg.go:283-317`):

- `TryEncode(dst, src, LevelFastest)` → returns nil if it doesn't beat a savings
  threshold; encodes into a caller buffer (no alloc).
- `DecodedLen(src)` → peek uncompressed length to size the destination.
- `Decode(dst, src)` → decode into a caller buffer.
- `MaxEncodedLen(n)` and a `MaxBlockSize` constant for bounds checks.

Iguana only has allocating `iguana_compress`/`iguana_decompress`: no
peek-length, no encode-into-caller-buffer, no abort-if-not-smaller.

✅ **`block` module**: `MAX_BLOCK_SIZE` (8 MiB), `max_encoded_len(n)`,
`decoded_len(src)` (peek without decoding), `try_encode(src, entropy, min_saved_frac)
-> Option` (give-up), `encode` (guaranteed ≤ `max_encoded_len` via raw fallback),
`decode`. Still allocating `Vec` (Rust grows buffers; no caller-buffer overrun risk),
so encode-into-fixed-buffer wasn't ported — revisit only if a zero-alloc grid path
needs it.

### 4. `Reader.Skip(n)` on a forward (non-seekable) reader

Ranged GET does `mzReader.Skip(decOff)` on a **pipe/stream** that is not
`Seek`-able (`object-api-utils.go:770`, `:1178`). This is distinct from
`SeekReader`, which requires `Read + Seek`. Iguana has no forward skip.

✅ **`Reader::skip(n) -> u64`** — forward discard on a non-seekable source; whole
blocks past the target are dropped **without decoding** (length peeked from the
frame via `decoded_len`), so a large skip is cheap.

## Tier 2 — parity / pooling ✅ DONE

§5–8 are implemented in `stream.rs` / `encoder.rs` and tested in
`tests/stream_and_block_api.rs` (the one exception, low-priority user-skippable
chunks, is noted under §8). ✅ lines record what satisfies each.

### 5. `Reader.Reset(r)` and writer reuse

MinIO pools readers (`bpool.Pool[*minlz.Reader]`, `object-api-utils.go:647-653`)
and calls `Reset` per request (`:763,765`) to avoid per-GET allocation. Iguana's
`Reader::new` consumes the source with no reset path — unacceptable churn on the
object-serving hot path.

✅ **`Reader::reset(inner)`** (reuses the decoder arena + buffers, keeps
`fallback`/`ignore` settings), and on the write side **`Writer::finish_in_place()`
+ `Writer::reset(w) -> W`** (reuse the ~2 MiB encoder scratch across streams).

### 6. `WriterConcurrency(n)` as a *Writer option*

MinIO wants `NewWriter(sink, WriterConcurrency(2))` — a `Write` sink that
parallelizes internally (`metacache-stream.go:74,225`, `stats-persist.go:190`).
Iguana's MT lives in the free function `stream::compress(reader, writer,
threads, …)`, which owns **both** ends; the incremental-`Write` `Writer` is
single-threaded.

✅ **`stream::ConcurrentWriter`** — a `Write` sink with an internal worker pool +
dedicated writer thread (bounded pipeline). Output is **byte-identical** to the
single-threaded `Writer` at the same entropy/block size (tested across 1/2/4
threads). Requires `W: Send + 'static` (the sink moves onto the writer thread).

### 7. Encryption padding

`minlz.WriterPadding(compPadEncrypted)` + `minlz.WriterPaddingSrc(rng)`
(`object-api-utils.go:1101`) pad compressed output with pseudo-random bytes so
ciphertext length does not leak object size. Iguana's stream has no padding
concept.

✅ **`Writer::padding(n)` + `Writer::padding_src(r)`** (and the same on
`ConcurrentWriter`) — round the stream length (before any embedded index trailer)
up to a multiple of `n`, filled from `r` (zeros if unset). For the encrypted path
(detached index via `finish_index`) the whole output is aligned; trailing padding
is invisible to the sequential `Reader` (it stops at the end marker).

### 8. Misc parity

- `ReaderIgnoreStreamIdentifier()` (`object-api-utils.go:652`) — skip the
  stream-magic check for skipped/mid-stream reads.
  ✅ **`Reader::ignore_stream_identifier(true)`** — assumes the source starts at the
  first frame (no 5-byte identifier consumed).
- `WriterLevel` → map MinLZ's levels (`encode.go`: `LevelSuperFast=-1`,
  `LevelUncompressed=0`, `LevelFastest=1`, `LevelBalanced=2`, `LevelSmallest=3`)
  onto iguana's `EntropyMode` + structural-only (`-0`).
  ✅ **`EntropyMode::from_minlz_level(level)`** — ≤ 1 → `None` (structural-only); ≥ 2
  → `Ans32`. Pass to `Writer::with_options`.
- User-skippable chunks (`MinUserSkippableChunk = 0x80`, `MaxUserChunkSize =
  1<<24-1`) for inline metadata — ⏳ **deferred** (low priority; iguana's stream
  format has no skippable-chunk frame type yet).

## Tier 3 — strategic (gate "full replacement")

### 9. Platform coverage (see SIMD status above) — largely DONE

The prior blocker — "every Linux/arm64 deployment runs scalar" — is resolved: the
four AVX-512 kernels are **ported to the SysV/Linux ABI** (built on Linux amd64), and
aarch64 Linux runs **SVE2** for entropy, match finder, *and* structural decode (a VLA
re-derivation, ~+20% over scalar at VL=128). Remaining, all lower-stakes: a
**Linux-runner runtime validation** of the SysV path (builds today; bodies shared with
Win64), **macOS** coverage (build enables only windows/linux), an **x86 SSE/AVX2**
fallback for pre-AVX-512 CPUs, and — for wider-VL ARM (Graviton 3/4) — the optional
SVE2 Stage-B batched token pre-decode (the `decode_tokens` sub-unit, shelved at VL=128).

### 10. Throughput on latency-sensitive paths (a finding, not a task)

Grid RPC is block-mode + `LevelFastest`, which the level mapping (§8) sends to
iguana `EntropyMode::None` (structural-only, no rANS). Even there, **encode is the
binding constraint and it is far below MinLZ**. Measured on the bake-off
(`plrabn12.txt`, 482 KB, single Sapphire Rapids box, `benches/codec.rs`):

| | iguana None | iguana Ans32 | MinLZ L1 | MinLZ L2 |
|---|---|---|---|---|
| encode | ~61 MiB/s | ~59 MiB/s | **323 MiB/s** | 213 MiB/s |
| decode (AVX-512) | ≥1.8 GiB/s¹ | **1.77 GiB/s** | 1.07 GiB/s | 964 MiB/s |

¹ structural-only (no entropy stage) — not separately benchmarked this run; bounded
below by the Ans32 figure. All from a Sapphire Rapids `cargo bench` run
(`target-cpu=sapphirerapids`).

So iguana's *fastest* encode is **~5× slower than MinLZ L1** (59 vs 323 MiB/s), and
MinLZ also has `LevelSuperFast (-1)` for the most latency-critical traffic — iguana
has no equivalent. Decode, though, is **no longer the gap**: with AVX-512, iguana
Ans32 decode (1.77 GiB/s) actually edges out MinLZ — the higher ratio costs nothing
on decode. The catch is **scalar decode is ~403 MiB/s** (≈2.7× behind MinLZ), so the
decode win requires a SIMD kernel linked; on arm64 the SVE2 structural kernel lands
decode at ~1.0 GiB/s (VL=128, more on wider cores).

Two precision caveats: (a) these are **large-corpus per-MiB throughputs** — there is
**no benchmark at grid message sizes** (single-/few-KB), where iguana's per-block
rANS-table build + 6-stream framing overhead is proportionally larger, so the real
small-message penalty is *worse* than the table implies; (b) off the AVX-512/SVE2
path entirely (no kernel linked) both encode and decode fall to the scalar floor.
MinLZ ships hand-written decode asm for **both** amd64 (`asm_amd64.s`) and arm64
(`asm_arm64.s`, PR #29), so it is fast everywhere MinIO ships.

**Conclusion:** iguana is a non-starter for grid RPC; it fits **object storage at
rest**, where the ~8–18% ratio win is worth a modest decode cost and encode latency
is not on the critical path.

## Bottom line

The codec core is complete and Go-validated, stream parity is there, and **Tier 1
and Tier 2 are now done** — detachable `Index`, `Reader::fallback`/`skip`/`reset`/
`ignore_stream_identifier`, writer reuse, `ConcurrentWriter`, `padding`, the `block`
grid primitives, and the level mapping (only low-priority user-skippable chunks
deferred). What remains is the **Tier 3 §9 tail** (Linux/SysV CI validation, macOS,
x86 SSE/AVX2 fallback, optional wider-VL ARM Stage-B batched pre-decode). The
**Linux/arm64 ABI port is no longer a blocker** — SysV/Linux amd64 (AVX-512) and
aarch64 SVE2 (entropy + match + structural) are in (§9).
Realistically iguana replaces MinLZ **for object storage at rest**, not for the
latency-bound grid RPC (which also has `LevelSuperFast=-1` for the most
speed-sensitive cases — a bar iguana's rANS decode cannot meet).
