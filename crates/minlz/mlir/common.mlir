// Names that the kernels share. `cargo xtask mlir` puts this file first, in front of the target
// file, and drops the functions a kernel does not call.

!p = !ptr.ptr<#llvm.address_space<0>>

// at returns p + o.
func.func private @at(%p: !p, %o: index) -> !p {
  %i = arith.index_cast %o : index to i64
  %r = ptr.ptr_add %p, %i : !p, i64
  return %r : !p
}

// at8 returns p + 8·i, the address of 64-bit word i at p.
func.func private @at8(%p: !p, %i: index) -> !p {
  %c8 = arith.constant 8 : index
  %o = arith.muli %i, %c8 : index
  %r = func.call @at(%p, %o) : (!p, index) -> !p
  return %r : !p
}

// byte returns the byte at p + o.
func.func private @byte(%p: !p, %o: index) -> index {
  %q = func.call @at(%p, %o) : (!p, index) -> !p
  %b = ptr.load %q : !p -> i8
  %r = arith.index_castui %b : i8 to index
  return %r : index
}

// word returns the 64-bit word at p + o.
func.func private @word(%p: !p, %o: index) -> i64 {
  %q = func.call @at(%p, %o) : (!p, index) -> !p
  %r = ptr.load %q alignment = 1 : !p -> i64
  return %r : i64
}

// arg and argp return word i of the kernel arguments a, for a word the kernel may also write.
func.func private @arg(%a: !p, %i: index) -> index {
  %q = func.call @at8(%a, %i) : (!p, index) -> !p
  %w = ptr.load %q alignment = 8 : !p -> i64
  %r = arith.index_castui %w : i64 to index
  return %r : index
}

func.func private @argp(%a: !p, %i: index) -> !p {
  %q = func.call @at8(%a, %i) : (!p, index) -> !p
  %r = ptr.load %q alignment = 8 : !p -> !p
  return %r : !p
}

// roarg and roargp return word i of the kernel arguments a for a word the kernel only ever reads.
// The load is invariant: no store of the kernel, and no store through a pointer it takes from a,
// reaches that word, so LLVM may read the word once and keep it in a register through the loops.
func.func private @roarg(%a: !p, %i: index) -> index {
  %q = func.call @at8(%a, %i) : (!p, index) -> !p
  %w = ptr.load %q invariant alignment = 8 : !p -> i64
  %r = arith.index_castui %w : i64 to index
  return %r : index
}

func.func private @roargp(%a: !p, %i: index) -> !p {
  %q = func.call @at8(%a, %i) : (!p, index) -> !p
  %r = ptr.load %q invariant alignment = 8 : !p -> !p
  return %r : !p
}
