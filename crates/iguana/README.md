# iguana (PoC)

A proof-of-concept Rust port of **Sneller Inc.'s Iguana** compressor
(`github.com/SnellerInc/sneller`, Apache-2.0), evaluated as a higher-ratio
alternative to the MinLZ codec in this workspace. Iguana is a *Lizard-derived LZ*
stage followed by a *vectorised rANS entropy* stage — the entropy stage is the
capability MinLZ lacks, and where its ~8–18% extra compression comes from.

## What's here

A **complete encode + decode codec**, scalar and SIMD, cross-validated
byte-for-byte against the Go reference in both directions:

- **Entropy coders** — 8-bit rANS (`ans1`), 32-way interleaved rANS (`ans32`), and
  4-bit nibble rANS, with frequency normalisation to a 12-bit total and Sneller's
  table serialisation. All Go-byte-validated.
- **Structural LZ** — the 6-stream token/offset/literal decode + overlapped
  wild-copy (`iguana_decompress`) and a 4-deep hash-chain encoder
  (`iguana_compress`). Decodes real Go Iguana output and its own output decodes in
  Go's decoder.
- **Four AVX-512 (NASM) kernels** — ans32 decode/encode, structural decode, match
  finder — reverse-translated from Sneller's Go Plan9 asm, assembled via `build.rs`
  (`nasm-rs`), called over `extern "C"` with runtime CPU dispatch + scalar fallback.
  A matching **SVE2** path (GAS `.S`) covers aarch64 Linux — ans32 decode/encode,
  match finder, *and* structural decode, all live (see `SVE2-PORT-PLAN.md`).

```rust
let packed = iguana::iguana_compress(data, iguana::EntropyMode::Ans32);
let back   = iguana::iguana_decompress(&packed)?;
assert_eq!(back, data);
```

## Result

On `plrabn12.txt`, Iguana Ans32 is **2.45×** vs MinLZ-L3 **2.20×** (~11% smaller),
and with the AVX-512 kernels its decode (1.77 GiB/s) actually edges out MinLZ — the
higher ratio costs nothing on decode. See `IGUANA.md` for the full bake-off,
cross-platform AVX-512-vs-SVE2 numbers, usage, streaming, and platform notes;
`REPLACEMENT-GAP.md` for what it would take to replace MinLZ in MinIO;
`CUDA-PORT-PLAN.md` for the GPU angle.

## Attribution

Port of Sneller Iguana (© 2023 Sneller, Inc., Apache-2.0). The rANS math follows
Fabian Giesen's public-domain `ryg_rans`; the table serialisation is Sneller's.
Exploratory PoC code, not a released codec (`version = 0.0.0`, `publish = false`).
