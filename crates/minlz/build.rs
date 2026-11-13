//! Sets the cfg `minlz_mlir` on the targets that have kernels lowered from MLIR: x86-64, and
//! aarch64 in little-endian mode. Code that runs a kernel also checks `not(miri)`, because Miri
//! cannot run assembly.

fn main() {
    println!("cargo::rerun-if-changed=build.rs");
    let var = |name| std::env::var(name).unwrap_or_default();
    let arch = var("CARGO_CFG_TARGET_ARCH");
    if arch == "x86_64" || (arch == "aarch64" && var("CARGO_CFG_TARGET_ENDIAN") == "little") {
        println!("cargo::rustc-cfg=minlz_mlir");
    }
}
