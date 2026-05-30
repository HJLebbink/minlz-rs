// Assembles the NASM AVX-512 kernels and links them into the crate.
//
// Supported today: x86_64 on **Windows (Win64 ABI)** and **Linux (SysV ABI)**.
// The kernel bodies are identical across the two; only the entry arg-register
// shuffle differs, selected at assemble time via the `IGUANA_SYSV` define (see
// the `%ifdef IGUANA_SYSV` blocks tagged `ABI: (A)` in asm/*.asm). Any other
// target (macOS, aarch64, non-AVX-512 x86) builds the portable scalar path.
//
// When the kernels are compiled and linked, this script emits the `iguana_asm`
// cfg; all the `#[cfg(iguana_asm)]` gates in the crate key off it, so the Rust
// side can never drift from what the build actually linked.
fn main() {
    for f in [
        "probe_avx512",
        "ans32_decode_avx512",
        "decompress_avx512",
        "match_avx512",
        "ans32_encode_avx512",
    ] {
        println!("cargo:rerun-if-changed=asm/{f}.asm");
    }
    for f in [
        "probe_sve2",
        "match_sve2",
        "ans32_decode_sve2",
        "ans32_encode_sve2",
        "decode_tokens_sve2",
        "decompress_sve2",
    ] {
        println!("cargo:rerun-if-changed=asm/{f}.S");
    }
    // Declare the custom cfgs so `unexpected_cfgs` stays quiet on every target.
    println!("cargo::rustc-check-cfg=cfg(iguana_asm)"); // x86-64 AVX-512 (NASM)
    println!("cargo::rustc-check-cfg=cfg(iguana_sve2)"); // aarch64 SVE2 (GAS .S)

    let arch = std::env::var("CARGO_CFG_TARGET_ARCH").unwrap_or_default();
    let os = std::env::var("CARGO_CFG_TARGET_OS").unwrap_or_default();

    // --- AArch64 Linux: SVE2 kernels (GAS `.S`, assembled by the C toolchain) ---
    if arch == "aarch64" && os == "linux" {
        build_sve2();
        return;
    }

    if arch != "x86_64" || !(os == "windows" || os == "linux") {
        // Scalar path: no asm, neither cfg set.
        return;
    }

    let mut build = nasm_rs::Build::new();
    build.file("asm/probe_avx512.asm");
    build.file("asm/ans32_decode_avx512.asm");
    build.file("asm/decompress_avx512.asm");
    build.file("asm/match_avx512.asm");
    build.file("asm/ans32_encode_avx512.asm");

    // SysV-ABI entry shuffle is a *target* concern (the kernel bodies are shared;
    // see the `%ifdef IGUANA_SYSV` blocks). NASM picks ELF vs COFF from the target
    // automatically.
    if os == "linux" {
        build.define("IGUANA_SYSV", None);
    }

    // Locating the assembler is a *host* concern (independent of the target). On
    // a Windows host the binary is `nasm.exe` and often off PATH; point at it
    // explicitly (honouring $NASM first). nasm-rs uses `nasm` on PATH otherwise.
    if cfg!(windows) && std::env::var_os("NASM").is_none() {
        for cand in [
            r"C:\Program Files\NASM\nasm.exe",
            r"C:\Program Files (x86)\NASM\nasm.exe",
        ] {
            if std::path::Path::new(cand).exists() {
                build.nasm(cand);
                break;
            }
        }
    }

    // The windows-msvc *target* archives via the MSVC librarian `lib.exe`, which
    // isn't on PATH (rustc finds the MSVC tools via vswhere). Locate it with the
    // `cc` crate. The Linux target uses `ar`, found on PATH on a Linux host.
    if os == "windows" {
        let target = std::env::var("TARGET").unwrap_or_default();
        if let Some(libtool) = cc::windows_registry::find_tool(&target, "lib.exe") {
            build.archiver(libtool.path());
        }
    }

    build
        .compile("iguana_asm")
        .expect("NASM assembly failed — install NASM or set the NASM env var");
    println!("cargo:rustc-link-lib=static=iguana_asm");
    // The kernels are compiled and linked: enable the FFI + dispatch in Rust.
    println!("cargo::rustc-cfg=iguana_asm");
}

/// Assemble the AArch64 SVE2 kernels (GAS `.S`) via the system C toolchain
/// (`cc` crate → gcc/as) and enable the `iguana_sve2` cfg. The `.arch` directive
/// inside each `.S` selects SVE2 + bitperm + sha3, so no `-march` flag is needed;
/// runtime CPU detection (`is_aarch64_feature_detected!`) gates the dispatch.
fn build_sve2() {
    cc::Build::new()
        .file("asm/probe_sve2.S")
        .file("asm/match_sve2.S")
        .file("asm/ans32_decode_sve2.S")
        .file("asm/ans32_encode_sve2.S")
        // Built + differential-tested, but NOT wired into the decoder: measured
        // slower than the auto-NEON scalar at VL=128 (see the file's banner).
        .file("asm/decode_tokens_sve2.S")
        // VLA structural decoder (Stage A, correctness-first); wired into
        // `decompress_block_simd` on SVE2 hosts.
        .file("asm/decompress_sve2.S")
        .compile("iguana_sve2_asm");
    println!("cargo:rustc-link-lib=static=iguana_sve2_asm");
    println!("cargo::rustc-cfg=iguana_sve2");
}
