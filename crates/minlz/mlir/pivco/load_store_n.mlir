// The @load_n and @store_n of the targets whose partial access is the kernel's own: they hand the
// bytes to @load_parts and @store_parts, which the kernel file writes. The AVX-512 target has a
// masked load and store of its own. `cargo xtask mlir` puts this file after the target file, which
// gives !b.

// load_n returns the n bytes at p (n up to 64), zero after them. It reads only those bytes.
func.func private @load_n(%p: !p, %n: index) -> !b {
  %r = func.call @load_parts(%p, %n) : (!p, index) -> !b
  return %r : !b
}

// store_n writes the first n bytes of v to p (n up to 64), and nothing else.
func.func private @store_n(%p: !p, %n: index, %v: !b) {
  func.call @store_parts(%p, %n, %v) : (!p, index, !b) -> ()
  return
}
