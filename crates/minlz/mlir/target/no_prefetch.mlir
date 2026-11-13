// The @prefetch of the targets that gain nothing from prefetching, the NEON and the SVE ones; the
// x86-64 target brings the lines into the cache and has a prefetch of its own. `cargo xtask mlir`
// puts this file after the target file.

// prefetch does nothing on this target. A prfm four blocks ahead made XXH3 slower on both GB10
// cores, the Cortex-X925 and the Cortex-A725.
func.func private @prefetch(%p: !p) {
  return
}
