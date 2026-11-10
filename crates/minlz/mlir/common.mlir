// Names that every kernel uses. `cargo xtask mlir` puts this file first, in front of the target
// file.

!p = !ptr.ptr<#llvm.address_space<0>>

// at returns p + o.
func.func private @at(%p: !p, %o: index) -> !p {
  %i = arith.index_cast %o : index to i64
  %r = ptr.ptr_add %p, %i : !p, i64
  return %r : !p
}
