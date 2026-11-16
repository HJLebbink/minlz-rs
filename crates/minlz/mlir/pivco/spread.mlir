// The @spread of the two x86-64 targets of pivco.mlir, which build the mask with @bits, the
// kernel's own. The NEON target has one of its own, which uses TBL and CMTST. `cargo xtask mlir`
// puts this file after the target file, which gives !b and !m.

// spread returns 255 in the bytes whose bit of t is set: a mask, which LLVM keeps in a mask
// register where it can.
func.func private @spread(%t: i64) -> !b {
  %m = func.call @bits(%t) : (i64) -> !m
  %r = arith.extsi %m : !m to !b
  return %r : !b
}
