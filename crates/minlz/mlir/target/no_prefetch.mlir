// The @prefetch of the aarch64 targets of XXH3 and CRC32C, which gain nothing from prefetching;
// the x86-64 targets take target/prefetch.mlir. `cargo xtask mlir` puts this file after the target
// file.

// prefetch does nothing on this target. A prfm four blocks ahead made XXH3 slower on both GB10
// cores, the Cortex-X925 and the Cortex-A725.
func.func private @prefetch(%p: !p) {
  return
}
