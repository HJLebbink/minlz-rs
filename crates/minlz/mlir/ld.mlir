// The @ld that the stats and the exec kernel share: the vector of the kernel's !v at p + o.
// `cargo xtask mlir` puts this file after the kernel file, which is the one that gives !v: the
// statistics read 64 bytes at a time, the operation loops 32.

// ld returns the bytes at p + o, as many as the kernel's !v holds.
func.func private @ld(%p: !p, %o: index) -> !v {
  %q = func.call @at(%p, %o) : (!p, index) -> !p
  %r = ptr.load %q alignment = 1 : !p -> !v
  return %r : !v
}
