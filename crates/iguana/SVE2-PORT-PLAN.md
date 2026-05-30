# Iguana on AArch64 (SVE2)

What's accelerated on ARM today, what's deliberately scalar, and what's left.

## Toolchain & dispatch

GAS `.S` kernels (`asm/*_sve2.S`, `.arch armv8-a+sve2+sve2-bitperm+sve2-sha3`),
assembled by the `cc` crate in `build.rs` on `aarch64-linux`, which sets the
`iguana_sve2` cfg. Runtime dispatch via `is_aarch64_feature_detected!("sve2")`;
scalar twin is the fallback on non-SVE2 / non-Linux ARM. Dev/validation box: GB10
(Cortex-X925/A725, **VL=128** — SVE2 at NEON width, so the win is op *richness*
— gather, `FDIV`, `BEXT` — not vector width).

## Status

| Kernel | State | VL=128 speed vs scalar |
|---|---|---|
| ans32 **decode** (`ans32_decode_sve2.S`) | ✅ done | ~2.6× |
| ans32 **encode** (`ans32_encode_sve2.S`) | ✅ done | ~1.23× (FDIV/emission-bound) |
| **match finder** (`match_sve2.S`) | ✅ done | (folded into encode) |
| **structural decode** (`decompress_sve2.S`) | ✅ done (Stage A) | ~1.2× at VL=128 (see below) |
| **token-decode sub-unit** (`decode_tokens_sve2.S`) | ⚠ shelved | 2.7× **slower** — unused (see below) |

All done kernels are byte-identical to the scalar oracle (the same differential
tests x86 uses) on real SVE2 silicon.

## Structural decode — VLA re-derivation (Stage A done)

`decompress_sve2.S` is a **vector-length-agnostic re-derivation** of the scalar
`decompress_block`, NOT a transliteration of the AVX-512 kernel (whose 512-bit =
16-dword batched structure — 64-token decode, 16-wide arming, `valignd` queues,
`pext`/`pdep` wide-varint — has no SVE analog). The per-token control flow is
scalar integer code (the decode is inherently serial: each match reads bytes the
previous tokens just produced); SVE2 carries the two bulk moves — the literal copy
and the overlapped match copy — as `whilelt` VLA loops that widen with VL.

**Measured GB10 (VL=128), plrabn12:** end-to-end iguana decode **~1.00 GiB/s vs
~828 MiB/s scalar (~+20%)**. The win at VL=128 is *not* from vector width (none over
NEON there) — it comes from dropping the scalar path's per-fetch bounds-checks and
`Vec::extend_from_within` call overhead, plus predicated copies. On ≥256-bit cores
(Graviton 3/4) the copy loops widen, so the gap should grow — that's the next thing
to measure. (Full cross-platform AVX-512-vs-SVE2 table: `IGUANA.md` §Performance.)

Contrast the **token-decode sub-unit** (`decode_tokens_sve2.S`): measured 2.7×
*slower* than the auto-NEON scalar at VL=128, because that step is pure byte-ALU
work at NEON width with no capability edge. It is **not used** by `decompress_sve2.S`
(Stage A keeps token-field decode scalar/serial); it is kept, validated, and reserved
for Stage B (batched pre-decode) on a wider-VL core.

## Remaining

- **Stage B — batched token pre-decode:** hide per-token latency by pre-decoding
  token fields in vector batches (reuse the validated `decode_tokens` logic). The
  real wide-VL speed lever; only worth wiring in where VL>128 makes it win.
- **Graviton 3/4 benchmark:** confirm the VL=256 widening of the Stage-A copy loops.
- **Productionize:** an ARM SVE2 CI lane (or QEMU for correctness); the differential
  + fuzz nets per kernel; scalar twin as the universal fallback.
