# Iguana → CUDA port plan (batched GPU decode)

## Objective

Decode (and later encode) Iguana on the GPU in a **batched** model: many
**independent** stream blocks resolved concurrently, one warp/CTA per block.
Format-compatible with the existing scalar/Go Iguana (the scalar decoder is the
correctness oracle), validated byte-for-byte. CUDA C in `.cu` files exporting
`extern "C"` host launchers, compiled by `nvcc` in `build.rs`, linked + dispatched
behind an `iguana_cuda` cfg — exactly mirroring the `iguana_asm` (NASM) and
`iguana_sve2` (GAS) seams already in the crate.

> **This is a throughput engine, not a latency engine.** Read the reality check
> before anything else. CUDA Iguana is for bulk/offline paths (migrate,
> re-compress, scan-many-objects) where thousands of blocks are in flight at once,
> on a **unified-memory** device. It is the wrong tool for grid RPC and for
> single-object online serving — the CPU AVX-512/SVE2 path wins there.

## Reality check (read first)

The whole effort is gated on **occupancy economics**, not on whether parallelism
exists — block independence already gives it (see below). Three facts shape every
decision:

1. **The batch model is native and already proven on CPU.** `stream.rs` splits
   input into **independent fixed-size blocks** and `stream::compress/decompress
   (…, threads, …)` already decodes them in parallel ("Blocks are independent, so
   they compress/decompress in parallel"). The GPU is the same `blocks × workers`
   decomposition with thousands of warps instead of N threads. **No format change,
   no re-chunking.** The MinLZ-compat target is independent blocks ≤ 8 MiB; the
   Iguana stream `block_size` is configurable.

2. **8 MiB blocks are coarse, but a block is not one unit of work.** A 1 GiB object
   is only ~128 blocks. GB10's 6144 cores want **thousands** of resident warps to
   hide memory latency, so *at one warp per block* 128 warps under-fills the machine
   by an order of magnitude. Two distinct facts are often conflated here:
   - You **cannot subdivide a block into independent cold-start sub-chunks** — there
     are no mid-block reset points, so you can't start decoding at 4 MiB without
     having produced 0…4 MiB.
   - You **can parallelize the *work* within a block** heavily: entropy decode (6
     streams × 32 states), token-field decode (lane = token), the destination/source
     prefix-sums, literal scatter, and far matches are all data-parallel; only the
     near/overlapping-match read-after-write hazard is serial (see "Intra-block
     parallelism" below). So a block absorbs **a CTA of several warps**, not one —
     the **effective** warp count per object is `blocks × useful-warps-per-block`.
   The knobs are therefore *how many blocks/objects in flight* **and** *how many
   useful warps per block*; both feed occupancy.

3. **Within a block, the structural decode is the hard, divergent part.** The
   entropy stage (ans32) is a clean warp fit; the Lizard structural decode has
   data-dependent token boundaries, overlapping match writes, and near/far match
   divergence — the genuine GPU-LZ research problem (what nvCOMP engineers spend
   their time on). Build it correct-first, optimize behind the differential oracle.

**The reusable asset is the scalar oracle + differential-test harness**, not any
prior asm. None of the AVX-512/SVE2 code carries over (SIMT is a third execution
model); kernels are **re-derived from the scalar reference** in CUDA C and
differential-tested against it byte-for-byte, exactly as the SVE2 kernels were.

## Where the parallelism actually comes from (MinIO read path)

The "single object starves the GPU" worry above is real but it must be measured
against MinIO's *actual* read path, which has parallelism at **several layers** —
only one of which is Iguana-block parallelism. Confusing the layers over-counts the
work the kernel sees. On GET, an object unwinds:

```
read shards (parallel fan-in) → EC reconstruct → Iguana decode (≤8 MiB blocks)
```

1. **Erasure-coded shards arrive in parallel, but they are not Iguana blocks.**
   Shards are stripes of the *compressed* object stream; reconstruction precedes
   decode and produces the single stream the decoder then splits into blocks. Shard
   fan-in is **transport** parallelism (and is exactly what the RDMA/GDS ingest path
   below feeds on), not decode-layer work — in the healthy read it's a concatenation,
   since `ReconstructData` only does Reed-Solomon GF math when data shards are
   *missing*. So shards add zero Iguana blocks and little GPU compute; they justify
   the *data path*, not the kernel occupancy.

2. **Multipart parts do not multiply Iguana blocks beyond the byte count.** A large
   object is cut into up to **10,000 parts**, each independently framed — but a
   1 GiB object is ~128 8 MiB blocks whether it is 1 part or 100. Parts only deliver
   the "thousands of blocks" shape when the object is genuinely **TiB-scale** (10,000
   parts × tens of blocks each → ~10⁵ blocks). This is the same conclusion as the
   reality check, now grounded in the S3 part limit: **part count is a transport
   convenience; total bytes ÷ block_size is the real block budget.**

3. **The gate is therefore a gradient in `cluster size × object size`, not a binary.**
   Two endpoints bound it:
   - **Large cluster + TiB objects + multipart RDMA ingest** → ~10⁵ resident blocks
     by construction; the SMs fill and the GPU batch wins. This is the green-light
     workload (bulk migrate / re-compress / scan-many / GPU-resident analytics ingest).
   - **Small (e.g. 4-node) cluster + ≤1 GiB objects + single-object serving** →
     ~10²–10³ blocks; the machine under-fills by an order of magnitude and the CPU
     SVE2/AVX-512 batch wins. Massive parallelism is *easy to manufacture* at cluster
     and object scale, and *structurally scarce* on small setups — so the Stage-1
     gate must be measured at **both** operating points, not one.

## Breakeven (back-of-envelope — Stage 1 replaces it with measurement)

Breakeven is where the GPU's throughput *ramp* crosses the CPU batch's *flat*
aggregate. GPU throughput rises ~linearly with resident-and-busy blocks until it
saturates at `N_sat`; the CPU is flat once it has ≥ its core count of blocks. So:

```
breakeven_blocks ≈ N_sat × (CPU_aggregate_throughput / GPU_saturated_throughput)
```

**Estimated GB10 inputs (order-of-magnitude, to be measured):**

| Quantity | Estimate | Basis |
|---|---|---|
| SMs | ~48 | 6144 cores ÷ 128; 192 tensor ÷ 4 |
| Grace CPU cores | ~20 (10 X925 + 10 A725) | GB10 spec |
| Shared memory pool | **one 273 GB/s pool, CPU+GPU** | unified memory — the key constraint |
| CPU decode aggregate | ~30–50 GB/s | ~1.5–2.5 GB/s/core × 20, SVE2-assisted |
| GPU ans32 saturated | ~100–190 GB/s | entropy stage — clean warp fit, fraction of 273 |
| GPU full-pipeline saturated | ~50–100 GB/s | structural divergence + match-copy caps it |
| `N_sat` (resident blocks) | **~600–670** | 16 KiB ans32 table/block ÷ ~200+ KiB shared/SM ≈ 12–14 blocks/SM × 48 |

**Two non-obvious constraints:**
- **CPU and GPU share 273 GB/s** — *not* free bandwidth. But the CPU path tops out
  at ~30–50 GB/s, far below 273, so the chip is **not** bandwidth-saturated by the
  CPU; it's CPU-core/latency-bound, leaving headroom the GPU exploits. The GPU's edge
  is parallel latency-hiding across 48 SMs, not extra bandwidth.
- **The 16 KiB per-block ans32 table caps resident occupancy at ~600–670 blocks**,
  not thousands (each block has its own freq table; CTAs can't share it). Intra-block
  warps relieve this — see "Intra-block parallelism".

**Plugging in:** ans32 → `~670 × (40/150) ≈ ~180 busy blocks` → batch of **~200–400
blocks (~2–3 GiB)**. Full pipeline → `~670 × (40/75) ≈ ~360`, and a first-cut
divergent kernel won't reach `N_sat` cleanly, pushing it toward **~1–3k blocks
(8–24 GiB)**. Folding in the intra-block multiplier (~4–8× effective warps/block)
pulls the *ans32* crossover down toward the **~1 GiB single-object** range.

**Net:** a 1 GiB single object (~128 blocks) is below breakeven on the one-warp-per-
block baseline; intra-block parallelism is what can bring it to the line, and TiB
batches sit far above it. The two numbers that move this most — GPU full-pipeline
saturated throughput and per-core CPU decode rate — are exactly what Stage 1
measures, so treat the above as the hypothesis the gate tests, not a result.

## Dev target: the GB10 (NVIDIA Grace-Blackwell)

The concrete dev box (`ssh gb10`), and ideal for the one reason that makes a GPU
codec viable for storage — **unified memory**:

- **128 GiB unified CPU-GPU memory, 273 GB/s, no PCIe copy.** Compressed input and
  the output arena are visible to both processors; `cudaMallocManaged` / HMM +
  prefetch, no explicit H2D/D2H of the bulk. **This is the feature that defeats the
  usual "compression on a discrete GPU loses to the PCIe round-trip" objection** —
  the decompressed output (larger than input) never crosses a bus.
- **6144 CUDA cores, Blackwell `sm_121a`,** driver 595.58.03, host CUDA toolkit
  **13.2** (per project notes). Compile a fatbin for `sm_121a` (+ PTX for JIT
  forward-compat).
- **⚠ Two real caveats (same as the SVE2 plan):**
  1. **Rust is NOT installed on GB10.** Install rustup + the repo there (push the
     branch or `git bundle`/`rsync`), and a CUDA build path (Stage 0).
  2. **GB10 is also the live vLLM server** (~102 GiB RAM in use, ~18 GiB free) —
     mind memory/SM contention; treat throughput numbers as a *floor*, schedule
     benches when the model is idle.
- **Discrete-GPU fallback** (e.g. a datacenter A100/H100, or the dev box's GTX
  1630) works for *correctness* but pays the PCIe tax — use only to prove
  portability, not for the speed gate.

## Data path — getting compressed blocks into GPU memory (the other half)

The kernels are the *compute* half; **getting the compressed bytes into GPU
memory without a CPU bounce is the equally important transport half**, and it is
the piece that removes the "discrete-GPU loses to the bus" objection. MinIO already
has it: `minio-rs/src/s3/rdma/` is a **GPUDirect Storage / RDMA** data path over
NVIDIA `cuObjClient` (`libcufile_rdma.so`, `cufile.h`). Payload moves out-of-band
over RDMA **directly into GPU device memory** (`MemoryType::CudaDevice`/`CudaManaged`,
`RdmaBuffer` wraps a `CUdeviceptr`); the HTTP control plane carries only an
`x-amz-rdma-token`. The bytes never touch host RAM.

**This composes with the codec and is otherwise orthogonal** — one moves bytes into
GPU memory, the other transforms them in place. Together they make the discrete-GPU
*and* networked cases viable, not just GB10's unified memory.

### Primary deployment: client-side ingest into a GPU-resident consumer

`minio-rs` is the **client** library, so the native shape is: a GPU workload
(training / inference / analytics / GPU SELECT) RDMA-GETs compressed `.igz` objects
**into its own GPU memory**, and CUDA Iguana decodes them in place for that workload.

- **The egress objection inverts.** You ship the *compressed* (smaller) bytes over
  the wire and expand them in GPU memory; the larger decompressed output **never
  crosses a bus**. This is the entire reason GPU-side decompression exists (the
  nvCOMP + GPUDirect Storage pattern) — Iguana just replaces the codec.
- **It supplies the batch shape the Stage-1 gate needs.** `multipart_rdma.rs` /
  `RdmaMultipartResponse` / `RdmaPart`: a part is an **independent stream of Iguana
  blocks** (each part holds `part_bytes ÷ block_size` blocks — parts are transport
  fan-in, not a 1:1 block mapping; see "Where the parallelism actually comes from").
  Streaming TiB across thousands of parts into GPU memory *is* the "thousands of
  blocks in flight" workload — at TiB scale the SMs fill by construction. At ≤1 GiB
  object scale the block budget is two orders of magnitude smaller and the gate
  favours the CPU; the win is bulk-shaped only.
- **Buffer ownership:** the consumer allocates the GPU buffer (`cudaMalloc` /
  managed), registers it (`ScopedRegistration` → `cuMemObjGetDescriptor`), RDMA-GETs
  compressed parts into it, then launches the batched decode kernel on those parts.
  The decode arena (output, ≤8 MiB/block) is a second GPU allocation.

### Secondary deployment: server-side GPU decode

If MinIO *server* wants to decompress on its own GPU (server-side SELECT, transcode,
re-compress at rest), the data is on local NVMe and the transport is the **storage**
cuFile variant (NVMe → GPU, GPUDirect Storage) rather than the network RDMA path —
the vendored `libcufile_rdma.so` covers both. This lives in the **Go server**, not
`minio-rs`, so it is a separate integration; the *kernels* are identical. Treat it
as a later target once the client-side ingest path is proven.

### Consequence for the kernels

The decode kernel must operate **on `CUdeviceptr` inputs already in GPU memory** (no
implicit copy-in), take the **batch of parts/blocks** as device-pointer arrays, and
leave output in GPU memory. The safe Rust wrapper's fallback (no GPU / no RDMA)
routes to the CPU batched `stream::decompress` over host buffers, unchanged.

## Toolchain & integration

- **Kernels:** `cuda/*.cu`, one translation unit per kernel family, each exporting
  `extern "C"` **host launcher** functions that take plain pointer/length/stream
  args (mirroring how the asm kernels take C-ABI args — keep CUDA out of the Rust
  type system). Device kernels are internal.
- **Build:** `build.rs` invokes `nvcc` (via the `cc` crate driving nvcc, or a
  direct `Command`) to produce a static lib + fatbin, links it, emits
  `cargo::rustc-cfg=iguana_cuda`. Declare `rustc-check-cfg=cfg(iguana_cuda)`
  alongside the existing two. nvcc must be on the build host (it is *not* on the
  dev-box PATH — locate it like the plan locates `nasm.exe`/`lib.exe`; honor a
  `$NVCC`/`$CUDA_PATH` env first).
- **FFI:** `unsafe extern "C"` declarations for the launchers; a **safe Rust
  wrapper** does device detection (`cudaGetDeviceCount > 0` + compute-capability
  check) and **falls back to the CPU batched path** when absent. Same shape as the
  `is_x86_feature_detected!` / `is_aarch64_feature_detected!` dispatch.
- **Memory:** prefer `cudaMallocManaged` + `cudaMemPrefetchAsync` on unified-memory
  devices; host-pinned staging + explicit copies on discrete GPUs. The wrapper
  picks based on a queried `cudaDevAttrPageableMemoryAccess`/managed-memory attr.
- **Avoid** the `cust`/`rust-cuda` toolchain for the kernels themselves — hand CUDA
  C keeps the tuned-asset model and matches the existing external-asm pattern; a
  thin Rust FFI layer is all that's needed.

## Parallelism model

- **Outer (free, abundant, coarse): block → CTA.** The batch API takes arrays of
  `{src_ptr, src_len}` and `{dst_ptr, dst_cap}` plus a per-block `status[]`; one
  kernel launch decodes the whole batch. This is the existing CPU MT decomposition,
  widened. The 8 MiB cap bounds each CTA's output arena → fixed scratch, no dynamic
  sizing.
- **Inner (the design work): warp-cooperative within a block.**
  - **ans32 entropy = 1 warp, lane *i* owns rANS state *i*** (32 states ↔ 32
    lanes). Lockstep, no divergence in the core update.
  - **Structural decode**: a warp decodes a *window* of tokens' fields in parallel
    (lane = token), prefix-sums lengths to place literals, then resolves matches.
- **Baseline mapping to measure: one warp per block, several blocks per CTA** (so a
  CTA's shared-memory ans table budget amortizes). Alternative — one block per CTA
  with multiple cooperating warps — is a Stage-2 tuning variable, decided by
  measurement, not up front (see "Intra-block parallelism").

## Intra-block parallelism (the occupancy multiplier)

A block is **not one unit of work**. You cannot subdivide it into independent
cold-start sub-chunks (no mid-block reset points — the LZ window is continuous), but
the *work inside* a block is mostly data-parallel, so a block productively absorbs
**a CTA of several warps**. This is the lever that attacks the single-object /
small-cluster occupancy problem: the **effective** warp count is
`blocks × useful-warps-per-block`, so lifting useful-warps-per-block from 1 to ~4
turns a 1 GiB object (128 blocks) from ~128 warps into ~512 — meaningfully filling
the ~48 SMs from a *single* object instead of starving them.

**Phase-by-phase within one block:**

| Phase | Parallel? | Available width |
|---|---|---|
| Entropy decode — 6 streams, ans32 | ✓ fully | 6 streams × 32 states ≈ **6 warps, free** (streams independent) |
| Token-field decode (litlen / matchlen / offset selector) | ✓ fully | lane = token; up to millions of tokens |
| Destination offset (where each token writes) | ✓ **scan** | prefix-sum, O(log n) — *not* serial |
| Literal source offset (position in literal stream) | ✓ scan | prefix-sum over litlens |
| Literal scatter | ✓ fully | independent writes once offsets known |
| **Far matches** (source already materialized) | ✓ fully | classified out, copied in parallel |
| **Near / overlapping matches** (source in the in-flight window) | ✗ **serial** | the one hard core — read-after-write hazard |

Only the near/overlapping-match hazard forces serialization, resolved by **wave
scheduling**: copy all far matches in parallel, then iterate near matches in
dependency waves. **Wave count = the match dependency graph's critical-path length,
not the token count** — shallow-and-wide for general data (large offsets point far
back), long only for repetitive/RLE data (small overlapping offsets).

**Two consequences worth designing around:**
- **Amdahl caps it.** Useful parallelism per block is ~**1–4 warps, data-dependent**
  (repetitive data → long serial near-match chains → low end; literal-heavy / lightly
  compressed → high end). It is a **~4–8× effective-occupancy multiplier, not
  unbounded** — enough to pull the ans32-stage breakeven toward the ~1 GiB
  single-object range, not enough to win on a 100 MiB object on a 4-node cluster.
- **It *relieves* the shared-memory ceiling.** The 16 KiB ans32 stats table is
  per-block, not per-warp, so putting 4–8 warps on a block amortizes one table over
  all of them. The per-block-table occupancy cap (~670 resident blocks; see
  "Breakeven") bites only when block count is *high*; when block count is *low* — the
  exact single-object case that starves the GPU — intra-block warps fill the SMs at
  trivial shared-mem cost. The two constraints are complementary.

The achieved useful-warps-per-block is the **central Stage-2 measurement**, not a
free parameter to assume.

## What maps cleanly vs what's hard

| Stage / idiom | CUDA | Difficulty |
|---|---|---|
| ans32 state update (and/shr/mul/add) | per-lane int ops, 32 lanes = 1 warp | ✓ clean |
| ans32 stats table lookup (`vpgatherdd`) | shared-memory table (16 KiB), per-lane load | ✓ clean — GPUs gather natively |
| ans32 renorm (which lanes < L, gather-by-rank) | `__ballot_sync` + `__popc` prefix-rank | ✓ **better** — one warp primitive, no scan |
| rANS divide (encode, `vdivpd {rz}`) | per-lane `__ddiv_rz` / float path | ✓ huge GPU FDIV throughput |
| token field decode (flags/litlen/matchlen) | per-lane byte ALU, lane = token | ✓ clean SIMT |
| literal placement | length prefix-sum (`__shfl`/scan) → parallel scatter | ≈ standard |
| **match copy (near/overlapping)** | wave classification far-vs-near, serialize near | ✗ **the hard, divergent core** |
| wild-copy / overlap-tolerant memcpy | coalesced `ld/st`, byte tail | ≈ memory-bound |
| match finder (encode) | parallel per-chunk hashing, atomic chains | ✗ **rewrite, not a port** |
| malformed-input safety | bounded writes + per-block error flag (no traps) | ✗ must design in |

## The two decode stages in CUDA detail

### ans32 decode — warp-cooperative (the easy, good fit; Stage 1 gate)

32 interleaved states ↔ a warp. Lane *i* holds `state[i]`. Per symbol: mask low 12
bits → **shared-memory** stats table (built once per block from the freq table, ~16
KiB), extract `(symbol, freq, bias)`, `state = (state>>12)*freq + bias`, store the
symbol byte. **Renorm** (the part SVE2 found hardest, trivial here): `p =
__ballot_sync(state < L)`; each active lane's source offset is `__popc(p &
((1<<lane)-1))` — a one-instruction warp prefix-rank — then it loads its renorm
word from the forward/reverse cursor by that rank. The contiguous stream words land
on the right lanes implicitly, no `vpexpand`/scan emulation. This kernel is the
**Stage-1 go/no-go**: it's the cleanest GPU fit and proves the batch + FFI +
dispatch + unified-memory machinery end-to-end.

### Structural (Lizard) decode — the hard kernel (Stage 2)

Six streams (tokens, literals, the offset streams, lengths). The token stream is
serial in *output* position. The warp scheme:

1. **Token-field decode (parallel):** lane = one of the next 32 tokens; decode
   flags, literal-length, match-length, offset-stream selector with per-lane byte
   ops. No `vpternlogd` needed (that was an x86 byte-shift fake).
2. **Literal scatter (parallel):** prefix-sum litlens → each token's output start
   and its source offset in the literal stream; copy literals coalesced.
3. **Match resolve (the divergence):** prefix-sum gives each match's destination;
   the source is `dst - offset`. Classify per wave: **far matches** (source already
   materialized, before the current window) copy in parallel; **near/overlapping
   matches** (source inside the in-flight window) carry a dependency and must
   resolve in token order. Iterate waves until the block is done.

**First cut = correctness over speed:** a single-thread-per-block transliteration
of `decompress_block` is the simplest correct kernel and already differential-tests
green; then lift the token decode + literal scatter to the warp, leaving match
resolution semi-serial; then attack the near-match waves. Build incrementally
behind the oracle, never one-shot — the explicit lesson from the x86 and SVE2
structural ports.

### Encode (Stage 4, optional — decode is the value)

- **Match finder:** Iguana's serial hash-chain matcher does **not** port; GPU LZ
  compressors parallelize by per-chunk independent hashing with atomic chain
  insertion (cf. nvCOMP LZ4). A rewrite, re-derived against the scalar encoder's
  output semantics (must stay decode-compatible, not byte-identical to the CPU
  parse).
- **rANS encode:** the divide-bound stage — GPU's strong suit. Warp of 32 states,
  `__ddiv_rz` for the exact floor, reverse emission. Byte-identical to scalar
  `ans32_encode` is achievable and is the validation target.

## Staged plan (gate after Stage 1)

Each stage independently testable against the scalar oracle. **Go/No-Go after
Stage 1** — prove batched GPU ans32 decode beats the CPU batched path on real
silicon before committing to the structural kernel.

### Stage 0 — Toolchain probe
A trivial `byte_sum` kernel (`cuda/probe.cu`, mirror `asm/probe_avx512.asm`): `nvcc` in
`build.rs` → static lib + fatbin → link → call the `extern "C"` launcher over FFI →
device detection + scalar fallback → differential vs the scalar twin on a batch.
Proves `.cu → link → launch → Rust` end-to-end on GB10, establishes the
`iguana_cuda` cfg, the batch-array calling convention, and the managed-memory path.

### Stage 1 — Batched ans32 **decode** (THE GATE)
Warp-per-block ans32 decode over a **batch** of blocks (shared-mem table,
ballot-renorm). Differential vs scalar `ans32_decode` byte-for-byte across sizes
1…65537 (every %32 tail) × alphabets 2/7/64/256 × batch sizes 1…thousands.
**Gate measurement — at both ends of the occupancy gradient** (see "Where the
parallelism actually comes from"): throughput vs the CPU `stream::decompress
(threads=all)` path on the GB10 ARM cores, measured at (a) a **small-cluster point**
(≤1 GiB corpus → ~10²–10³ blocks, the single-object/4-node shape) and (b) a
**bulk point** (TiB-shaped corpus → ~10⁵ blocks, the multipart-ingest shape). **Go**
only if the GPU clears the CPU batch *at the bulk point* by a margin that justifies
the structural kernel; the small-cluster point is expected to favour the CPU and
that is the documented limit of the technique, not a failure. Note ans32 alone is
entropy-only, so the honest gate also projects the full-pipeline number (decode is
structural-bound; see SVE2 plan profiling).

### Stage 2 — Batched structural decode (the hard one)
Correctness-first thread-per-block, then warp-cooperative token-decode + literal
scatter, then near-match wave resolution. Differential vs `decompress_block` and vs
genuine Go `EntropyNone` fixtures; fuzz malformed input for bounded-write safety
(per-block error flag, never a device trap). Incremental, fuzzed at each step.

### Stage 3 — Full batched decode pipeline + bake-off
Compose entropy + structural into one batched decode of real default-mode Iguana
(`EntropyANS32`). End-to-end differential vs scalar over the existing fixture +
fuzz corpus. **Bake-off:** GB10 GPU batch vs GB10 SVE2 CPU batch vs x86 AVX-512 CPU
batch vs **nvCOMP GDeflate/ANS** (the alternative — see below), on ratio (unchanged,
~8% over MinLZ) and **batched** decode throughput and end-to-end latency for a
representative bulk job.

### Stage 4 — Batched encode (optional)
GPU match finder (per-chunk parallel) + rANS encode (`__ddiv_rz`). Output
decode-compatible (round-trips through scalar + GPU decoders). Only if a GPU
*compress* workload exists (bulk re-compress/migrate) — decode is the primary win.

### Stage 5 — Productionize / integrate
`iguana_cuda` cfg + CI lane with a CUDA runner (or compile-only where no GPU);
managed-vs-pinned memory selection; a **batch decode/encode public API** shaped for
MinIO's bulk paths (migrate, re-compress, scan); docs; the differential + fuzz nets
per kernel; scalar twin as the universal fallback (and the miri/fuzz path — CUDA is
opaque to miri, like the asm).

## Memory & data movement

See **Data path** above for how compressed blocks reach GPU memory (cuObj RDMA
client-side, cuFile GDS server-side). This section covers what happens once they're
resident.

- **Two viable ingress models, both bounce-free:** (a) **RDMA/GDS** lands compressed
  bytes directly in `CUdeviceptr` memory (discrete + networked GPUs) — the general
  case; (b) **unified memory (GB10)** — `cudaMallocManaged` + `cudaMemPrefetchAsync`,
  no copy at all. The kernels are identical; only the wrapper's buffer source differs.
  In both, the egress of decompressed (larger) data never crosses a bus.
- **Coalescing:** the copy-bound structural tail wants coalesced loads/stores; the
  6-stream layout is per-block, so within a warp the streams are read with
  stride — measure and, if needed, stage hot stream prefixes in shared memory.
- **Batch sizing:** keep ~thousands of blocks resident to fill the SMs; the 8 MiB
  cap bounds per-CTA output so the scheduler can pack many CTAs. Tune
  blocks-per-CTA and warps-per-block by measurement (Stage 1/2).
- **Discrete GPU:** pinned host staging + double-buffered streams to overlap copy
  and compute — but the PCIe tax means it only pays on huge batches; not the target.

## Validation & safety

- **Scalar oracle = ground truth.** Every kernel differential-tests byte-for-byte
  against `iguana_decompress`/`ans32_decode`/`iguana_compress` per block, reusing
  the existing Go fixtures + fuzz corpus, now driven over batches.
- **Malformed-input safety on-device:** no OOB writes (bound every store to the
  ≤8 MiB arena), no device traps — set a per-block `status` code and skip. A bad
  block must not corrupt its neighbours in the batch.
- **miri/fuzz live on the CPU twin** (CUDA is opaque to miri, exactly like the asm
  kernels); the differential harness is the asm-bug net's CUDA equivalent.

## Risks & effort (honest)

- **Occupancy economics is the product risk, not a code risk:** if the real
  workload can't keep enough work in flight, the GPU starves and the CPU path wins —
  settle this *before* Stage 2. Effective occupancy is `blocks ×
  useful-warps-per-block`, so the **intra-block multiplier** (~4–8×, data-dependent;
  see "Intra-block parallelism") is the knob that can rescue the single-object case —
  but its achieved value is unproven until Stage 2 and must not be assumed in the gate.
- **The structural decoder is the engineering risk** (near-match divergence, the
  copy-bound tail, coalescing) — the bulk of the work, built incrementally behind
  the oracle, never one-shot. Same shape as the x86/SVE2 structural ports.
- **nvCOMP makes the build-vs-buy question sharp** (next section).
- **Effort:** Stage 0–1 ≈ days (ans32 is a clean warp fit + ballot-renorm). Stage 2
  ≈ several weeks (the divergent structural kernel). Stage 3 ≈ days once 1+2 land.
  Stage 4 (encode) ≈ weeks. **Total: multi-week to a couple of months**, dominated
  by Stage 2 and gated on Stage 1.

## Alternative worth weighing: nvCOMP

NVIDIA's nvCOMP already ships **GPU ANS and GDeflate** (LZ + entropy, batched) —
structurally the *same shape* as Iguana, production-tuned, maintained by NVIDIA. If
all you need is "compress/decompress many chunks fast on a GPU," **use nvCOMP** — a
bespoke CUDA Iguana would be reinventing it at lower maturity.

**The only justification for bespoke CUDA Iguana is format compatibility:** nvCOMP
cannot read Iguana's `.igz` format, so if you have already stored data as Iguana
(for its ~8% ratio edge over MinLZ) and need a *GPU bulk-read/migration* path over
it, a CUDA Iguana **decoder** earns its keep. Absent stored-format lock-in, the
ratio edge does not justify a bespoke GPU codec over nvCOMP. **So scope tightly: a
decode-only CUDA Iguana for bulk reads of existing Iguana data is the defensible
project; a full GPU codec to beat nvCOMP is not.**

## Bottom line / decision gate

CUDA Iguana is **feasible and the parallelism is free** (independent ≤8 MiB blocks,
already exploited by the CPU MT path), and the **data-movement objection is solved**:
MinIO's existing cuObj RDMA / GPUDirect Storage path (`minio-rs/src/s3/rdma/`) lands
compressed bytes directly in GPU memory on *any* GPU (GB10's unified memory makes it
zero-copy, but RDMA generalizes it to discrete + networked GPUs), and decompressing
on-GPU means the larger output never crosses a bus. The entropy stage is a clean,
elegant warp fit (ballot-renorm beats both SIMD ports); the structural stage is the
hard, divergent GPU-LZ problem and the bulk of the effort.

It is worth building **only** if (a) the workload is batch-shaped — thousands of
blocks/objects concurrently (bulk migrate, re-compress, scan-many, **or TiB-scale
RDMA ingest into a GPU-resident consumer**, which supplies exactly that shape via
multipart parts → blocks), not single-object online serving or grid RPC; **and**
(b) format compatibility with stored Iguana data is the goal (else use nvCOMP). The
Stage-1 gate caps the downside: prove batched GPU ans32 decode beats the CPU batch
on GB10 before committing to the structural kernel.

**The one question that settles it:** is there a workload that keeps ~thousands of
8 MiB Iguana blocks in flight at once? The block budget is **total bytes ÷
block_size**, not part or shard count — multipart parts and EC shards are transport
fan-in, not extra blocks (see "Where the parallelism actually comes from"). So the
answer is a gradient: at **TiB scale on a large cluster** fed by the RDMA/GDS ingest
path the SMs fill by construction → decode-only CUDA Iguana is a real throughput
engine and the larger decompressed output stays on-GPU for the consumer; at
**≤1 GiB objects / single-object serving / small (4-node) clusters** the block
budget is two orders of magnitude too small → keep the CPU SVE2/AVX-512 path. The
Stage-1 gate measures both ends so the cutover point is a number, not a guess.
