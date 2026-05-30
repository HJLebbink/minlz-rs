# Iguana support — overview

A short guide to the **Iguana** codec in this workspace: what it is, how to use
it, how it performs, and how it's validated.

## What it is

Iguana is a Rust port of **Sneller's Iguana** compressor (Apache-2.0): a
Lizard-derived **LZ stage** followed by a **vectorised rANS entropy stage**. The
entropy stage is the capability MinLZ lacks, and it's where Iguana's extra
compression comes from. The core codec is **whole-buffer**, but a block-framed
**streaming** layer (`iguana::stream`) adds incremental `Write`/`Read`,
multi-threaded encode/decode, and random-access seek on top of it — matching
MinLZ's stream features (see [Streaming](#streaming)).

The port lives in `crates/iguana` and is wired into the `mz` CLI. It targets
**x86-64 with AVX-512** (Windows *and* Linux) and **aarch64 with SVE2** (Linux;
entropy, match finder, *and* structural decode); on any other CPU/OS it
transparently falls back to portable scalar code (same output, lower speed).

## Status: complete and Go-validated

Everything Sneller's Iguana implements is ported and cross-validated **byte-for-byte
against the Go reference**, in both directions (our decode reproduces Go's bytes,
and our encode reproduces Go's bytes exactly):

| Piece | Status |
|-------|--------|
| Structural LZ encode + decode | ✅ |
| Entropy: None / ANS1 / ANS32 / ANS-nibble | ✅ all four |
| AVX-512 kernels: ans32 decode, structural decode, match finder, ans32 encode | ✅ all four (NASM) |
| SVE2 kernels: ans32 decode, ans32 encode, match finder, structural decode | ✅ four live (GAS) |

The four AVX-512 kernels are line-by-line NASM translations of Sneller's
hand-written Go assembly; the kernel bodies are shared across the **Win64 and
SysV/Linux ABIs** (selected by the `IGUANA_SYSV` build flag), so iguana is
accelerated on both Windows and Linux x86-64. Only the ABI seam differs from the
original — those lines are tagged `ABI:` in the `.asm` files so they can be audited
in isolation. The aarch64 SVE2 kernels (GAS `.S`) are separate **re-derivations**
(the AVX-512 routines are built around 512-bit/16-dword batches that have no SVE
analog), validated byte-for-byte against the same scalar oracles — see
`SVE2-PORT-PLAN.md`. (A fifth SVE2 artifact, the `decode_tokens` sub-unit, is built
and validated but **shelved/unused** — slower than auto-NEON at VL=128; it's a
starting point for a wider-VL optimization.)

## How to use it

### Command line (`mz`)

```sh
# Compress with Iguana instead of MinLZ -> writes file.txt.igz
mz c --iguana file.txt

# Structural-only (no entropy stage)
mz c --iguana -0 file.txt

# Decompress — AUTO-DETECTS .igz vs .mz, no flag needed
mz d file.txt.igz
mz file.txt.igz            # extension also infers "decompress"
cat file.igz | mz d -c -   # works from stdin too
```

`.igz` files start with a 4-byte magic (`IGZS`) that decompression detects
automatically; the container is the block-framed Iguana stream, so `--iguana`
compresses with bounded memory (works on stdin and huge files). MinLZ files are
unaffected. The MinLZ random-access features (`--offset`, `--tail`, `--follow`,
seek index) are **not** available with `--iguana` — see [Streaming](#streaming).

### Library (`iguana` crate)

```rust
use iguana::{iguana_compress, iguana_decompress, EntropyMode};

let packed = iguana_compress(data, EntropyMode::Ans32); // self-framed
let back   = iguana_decompress(&packed)?;               // auto-detects entropy
assert_eq!(back, data);
```

`iguana_decompress` reads the per-stream entropy mode from the payload, so the
caller doesn't choose it. `iguana_decompress_simd` is the same but routes the
structural decode through the SIMD kernel when available (AVX-512 on x86-64, SVE2
on aarch64). The individual entropy coders are also public (`ans1_*`, `ans32_*`,
`ans_nibble_*`).

## Streaming

The Iguana **codec** is whole-buffer, but a **block-framed streaming layer**
(`iguana::stream`) provides incremental `Write`/`Read`, a multi-threaded bounded
pipeline, *and* random-access seek on top of it — full parity with MinLZ's
stream features.

|                       | MinLZ                         | Iguana                                |
|-----------------------|-------------------------------|---------------------------------------|
| Streaming             | **Yes** (`stream::Writer/Reader`) | **Yes** (`iguana::stream::Writer/Reader`) |
| Incremental encode    | `Write`, per block            | `Write`, per block                    |
| Incremental decode    | `Read` / `BufRead`            | `Read`                                |
| Bounded memory        | yes (one block)               | yes (one block, or `O(threads×block)` MT) |
| Multi-threaded        | yes (`MtWriter`/`MtReader`)   | **yes** (`stream::compress`/`decompress`) |
| Random access / seek  | yes (seek index)              | **yes** (`stream::SeekReader`, block-granular) |

### Why Iguana needs a block layer to stream

The per-block Iguana **codec** is genuinely whole-buffer, for two structural
reasons: (1) **rANS is LIFO** — the encoder processes symbols back-to-front and
the decoder reads state from the *tail* and walks backward; and (2) **control
framing is written backwards** — the total length, entropy header, and six stream
lengths are appended in reverse at the end. So `iguana_compress` / `iguana_decompress`
must see the whole block at once.

Streaming is therefore achieved the same way MinLZ does it: split the input into
independent fixed-size blocks, compress each block whole, and frame them. The
format is:

```text
[4B "IGZS"][1B version]  ( [4B LE compressed-len][compressed block] )*  [4B LE 0]
```

### Using it

```rust
use iguana::stream::{Reader, Writer};
use std::io::{Read, Write};

let mut w = Writer::new(sink);              // default ANS32, 1 MiB blocks
// or: Writer::with_options(sink, EntropyMode::Ans32, block_size)
w.write_all(chunk1)?; w.write_all(chunk2)?; // feed incrementally
let sink = w.finish()?;                       // flush final block + end marker

let mut out = Vec::new();
Reader::new(source).read_to_end(&mut out)?;   // decodes block-by-block
```

For **parallel** encode/decode, use the free functions, which run a bounded
pipeline across `threads` workers (memory `O(threads × block)`) and produce
output **byte-identical** to the single-threaded path:

```rust
iguana::stream::compress(reader, writer, threads, EntropyMode::Ans32, block_size)?;
iguana::stream::decompress(reader, writer, threads)?;   // decode uses the AVX-512 kernel
```

In the CLI, `mz c --iguana` uses the streaming writer (memory bounded; works on
stdin and arbitrarily large files), `mz d` stream-decodes `.igz`, and
`--threads`/`--cpu` selects the worker count for both. `--block-size` sets the
block size.

**Measured scaling** (10.9 MB English text, 24-core box, vs 1 thread): encode
56 → 172 MiB/s (≈3.1× at 8 threads, match-finder/rANS bound); decode 282 →
373 MiB/s (already kernel-fast single-threaded, so more bandwidth- than
CPU-bound). MT only helps when the input spans many blocks.

### Random access (seek)

Every `.igz` carries a **seek index** appended after the end marker — a
`(compressed_offset, uncompressed_offset)` per block. It costs ~16 bytes/block
(≈16 ppm of a 1 MiB-block stream), has **zero impact on sequential decode** (a
normal reader stops at the end marker and never reads it), and is backward-
compatible. `SeekReader<R: Read + Seek>` implements `Read + Seek` over the
uncompressed bytes:

```rust
let mut sr = iguana::stream::SeekReader::new(file)?;   // loads the index from the tail
sr.seek(SeekFrom::Start(uncompressed_offset))?;        // or End(-n) for a tail
sr.read_exact(&mut buf)?;
```

In the CLI, `mz d --offset N` / `--tail N` (with the `+nl` line-align suffix)
work on `.igz` exactly as on MinLZ. A seek binary-searches the index, seeks the
file to the containing block, and decodes that **one** block — so seek
resolution = the block size, and the cost is one block-decode (≈0.2 ms at
64 KiB, ≈3.5 ms at 1 MiB). Smaller `--block-size` → finer/faster seeks at a small
ratio cost. Requires a seekable input (a file, not a pipe). `--follow` remains
MinLZ-only.

### Ratio cost of block-framing

Smaller blocks reset the LZ window and rebuild the rANS table more often, so the
ratio drops — but **both codecs degrade at the same rate, so Iguana keeps its
lead over MinLZ at every block size.** Measured on a 1.16 MB English corpus
(independent blocks, Iguana-Ans32 vs MinLZ-L3):

| block size | Iguana ratio | MinLZ ratio | Iguana / MinLZ size |
|------------|-------------:|------------:|--------------------:|
| whole      | 2.66×        | 2.46×       | 92.6%               |
| 256 KiB    | 2.59×        | 2.31×       | 89.4%               |
| 64 KiB     | 2.37×        | 2.08×       | 87.6%               |
| 16 KiB     | 1.99×        | 1.75×       | 88.0%               |
| 4 KiB      | 1.66×        | 1.47×       | 88.1%               |

So at any sane block size (64 KiB–2 MiB), streaming Iguana stays ~10–13% smaller
than MinLZ. Files ≤ the block size (1 MiB default) become a single block, i.e.
whole-buffer ratio plus ~9 bytes of framing.

### Rule of thumb

- **MinLZ** when raw decode throughput is the priority, or for `tail -f`
  (`--follow`, the one stream feature Iguana doesn't have).
- **Iguana** when ratio matters most; it now matches MinLZ on streaming, bounded
  memory, multi-threading, and `--offset`/`--tail` random access.

## Performance

All numbers below are on **plrabn12.txt** (482 KB real English text), via
`cargo bench -p iguana --bench codec`, each platform built for its native CPU
(`RUSTFLAGS="-C target-cpu=…"`). Throughput is min-of-samples wall-clock; expect a
±15% run-to-run noise floor. Compression ratio is identical on every platform (same
codec): **Iguana Ans1 2.46×, Ans32 2.45×, Nibble 2.14×, None 1.93×**.

### vs MinLZ (Sapphire Rapids, AVX-512)

| codec | ratio | encode | decode |
|-------|------:|-------:|-------:|
| **Iguana Ans32** | **2.45×** | 59 MiB/s | **1.77 GiB/s** (AVX-512) |
| MinLZ L3 (best) | 2.20× | 30 MiB/s | 1.02 GiB/s |
| MinLZ L2 (default) | 1.99× | 213 MiB/s | 964 MiB/s |
| MinLZ L1 (fastest) | 1.68× | 323 MiB/s | 1.07 GiB/s |

**Takeaways:**
- **Ratio:** Iguana is ~8–18% smaller than MinLZ depending on the corpus
  (~11% over MinLZ's best level here; ~18% over MinLZ default on `alice29`).
- **Encode:** slow in absolute terms (the rANS entropy + chained match finder),
  but comparable to / faster than MinLZ's best-ratio level (L3).
- **Decode:** with the AVX-512 structural kernel lifting decode ~4.4× over its own
  scalar path, Iguana Ans32 decode (1.77 GiB/s) actually **edges out** MinLZ here —
  i.e. the higher ratio comes at no decode-speed cost on AVX-512 hardware.

**Use Iguana when ratio matters more than throughput** (cold/archival data,
bandwidth-bound transfers). **Use MinLZ when speed dominates** (hot paths,
high-throughput pipelines) or for `tail -f` (`--follow`).

### Cross-platform: AVX-512 vs SVE2

Iguana Ans32 on **Sapphire Rapids** (AVX-512, 512-bit) vs **NVIDIA GB10 / Cortex-X925**
(SVE2 at VL=128). These are different machines, so this is "what each platform
delivers end-to-end on this codec," not an ISA-normalised comparison.

| operation | Sapphire Rapids (AVX-512) | GB10 (SVE2, VL=128) |
|-----------|--------------------------:|--------------------:|
| **compress** (Ans32) | 59 MiB/s | **83 MiB/s** |
| **decompress** (Ans32) | **1.77 GiB/s** | 1.00 GiB/s |

Per-kernel, scalar twin → SIMD kernel (the `simd` label = AVX-512 on x86-64, SVE2 on
aarch64):

| kernel | SPR scalar | **SPR AVX-512** | GB10 scalar | **GB10 SVE2** |
|--------|-----------:|----------------:|------------:|--------------:|
| ans32 decode | 293 MiB/s | **2.00 GiB/s** (7.0×) | 374 MiB/s | **1.02 GiB/s** (2.8×) |
| ans32 encode | 223 MiB/s | **934 MiB/s** (4.2×) | 348 MiB/s | **426 MiB/s** (1.2×) |
| structural decode (e2e) | 403 MiB/s | **1.77 GiB/s** (4.4×) | 828 MiB/s | **1.00 GiB/s** (1.2×) |

**Takeaways:**
- **Decode** is AVX-512's win (1.77 vs 1.00 GiB/s): the 512-bit kernel moves far more
  per instruction than SVE2 at VL=128 (= NEON width). On a ≥256-bit SVE2 core
  (Graviton 3/4) the VLA copy loops widen and should close part of this gap.
- **Encode** actually favours the GB10 (83 vs 59 MiB/s): end-to-end encode is
  match-finder/rANS-division bound, where the X925's scalar/integer throughput leads
  and AVX-512's vector-divide edge matters less.
- The GB10's **scalar baseline is much higher** than SPR's (e.g. decode 828 vs
  403 MiB/s), which is *also why* SVE2 adds less on top at VL=128 — there's less
  headroom over an already-fast auto-NEON scalar. The SVE2 structural kernel is a VLA
  re-derivation (not a transliteration); its +20%-at-VL=128 win comes from dropping
  the scalar path's per-fetch bounds-checks and `Vec` overhead, not from vector width.
  See `SVE2-PORT-PLAN.md`.

## How it's validated

- **Go cross-validation** (the gold standard): fixtures generated from the Go
  reference; tests assert byte-identical output in both directions for every
  entropy mode (`tests/go_*_fixtures.rs`).
- **Differential testing**: each AVX-512 kernel is checked against a scalar twin
  oracle over fuzzed inputs (`tests/avx512_*_diff.rs`, `src/matcher.rs`).
- **Round-trip + composition**: encode→decode equality across sizes, distributions,
  and edge cases, plus end-to-end through the `mz` CLI.

Run it all: `cargo test -p iguana` (and `cargo test -p mz` for the CLI).

## Platform & build notes

- AVX-512 kernels run on **x86-64 Windows (Win64 ABI) and Linux (SysV ABI)**,
  assembled by **NASM** at build time (`build.rs` via `nasm-rs`; NASM must be
  installed). The kernel bodies are shared; only the entry arg-register shuffle
  differs (selected via the `IGUANA_SYSV` define, tagged `ABI: (A)` in `asm/*.asm`)
  — the prologue saves the Win64 non-volatile set, a superset of SysV's, so it is
  correct on both. When the kernels are linked, `build.rs` sets the `iguana_asm`
  cfg that gates all the Rust FFI/dispatch. Any other target (macOS, aarch64,
  non-AVX-512 x86) builds the portable scalar path with no external toolchain.
- The crate is a PoC (`version = 0.0.0`, `publish = false`).

## Where the code lives

```
crates/iguana/
  src/lib.rs          entropy coders (ans1/ans32/nibble) + public API
  src/structural.rs   LZ decoder + AVX-512/SVE2 decode wiring
  src/encoder.rs      LZ encoder (4-deep hash chain, lazy matching)
  src/matcher.rs      match-finder kernel binding + scalar oracle
  asm/*.asm           the four NASM AVX-512 kernels (ABI-tagged)
  asm/*_sve2.S        the aarch64 SVE2 kernels (see SVE2-PORT-PLAN.md)
  benches/codec.rs    Iguana-vs-MinLZ bake-off
bin/mz/               `--iguana` flag + auto-detecting decompress
```
