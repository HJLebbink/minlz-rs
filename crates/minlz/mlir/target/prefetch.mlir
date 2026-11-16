// The @prefetch of the x86-64 targets of XXH3 and CRC32C. `cargo xtask mlir` puts this file after
// the target file.

// prefetch brings the 64 bytes at p into the cache hierarchy, down to the L1 (hint T0). It never
// faults, so a loop may name an address past the end of its input.
func.func private @prefetch(%p: !p) {
  %read = arith.constant 0 : i32
  %locality = arith.constant 3 : i32
  %icc = arith.constant 1 : i32
  llvm.call_intrinsic "llvm.prefetch"(%p, %read, %locality, %icc) : (!p, i32, i32, i32) -> ()
  return
}
