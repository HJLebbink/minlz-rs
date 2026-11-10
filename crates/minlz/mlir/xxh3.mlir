// The XXH3 stripe loop for every target: accumulate_512 and scramble of the xxHash specification.
// `cargo xtask mlir` puts common.mlir, a target file (target/*.mlir) and a lane layout
// (xxh3_split.mlir or xxh3_whole.mlir) in front of this file and lowers the result once per
// target. The naked functions in crates/minlz/src/xxh3/mlir.rs hold the output.
//
// The loop holds the eight 64-bit accumulator lanes as one value of type !acc, in the order the
// lane layout keeps them. It uses these names from the files in front of it:
// - !p, the pointer type, and @at, from common.mlir; !acc;
// - @lanes_load(!p) -> !acc and @lanes_store(!acc, !p), which read and write 8 lanes;
// - @swap(!acc) -> !acc, which exchanges neighboring lanes;
// - @lohi(!acc) -> !acc, the product of the low and the high 32-bit half of each lane.
// The spec adds each stripe's data to the accumulator with neighboring lanes swapped. The loop adds
// the data of many stripes unswapped and swaps their sum once (@settle): the same lanes, with one
// swap instead of one per stripe. Everything else works lane by lane and needs no layout. An SVE
// target's !acc holds 8 lanes at one vector length only: the Rust side calls its kernels only at
// that length.
//
// The keys argument is the table of secret stripes of xxh3::KEYS: row r holds the 64 secret
// bytes at offset 8·r for r ≤ 16, and row 17 those at offset 121, which the last stripe uses.
// Row 16 is also the scramble key.

// scramble returns (a ^ a >> 47 ^ k) · PRIME32_1 per lane.
func.func private @scramble(%a: !acc, %k: !acc) -> !acc {
  %c47 = arith.constant dense<47> : !acc
  %prime = arith.constant dense<2654435761> : !acc
  %s = arith.shrui %a, %c47 : !acc
  %x = arith.xori %a, %s : !acc
  %y = arith.xori %x, %k : !acc
  %r = arith.muli %y, %prime : !acc
  return %r : !acc
}

// stripe returns (a, s) after one stripe, the data at p and the key at k: a plus its products,
// s plus its data.
func.func private @stripe(%a: !acc, %s: !acc, %p: !p, %k: !p) -> (!acc, !acc) {
  %d = func.call @lanes_load(%p) : (!p) -> !acc
  %kk = func.call @lanes_load(%k) : (!p) -> !acc
  %x = arith.xori %d, %kk : !acc
  %m = func.call @lohi(%x) : (!acc) -> !acc
  %ra = arith.addi %a, %m : !acc
  %rs = arith.addi %s, %d : !acc
  return %ra, %rs : !acc, !acc
}

// stripe_at returns (a, s) after the stripe at p + o, with the key at k + o.
func.func private @stripe_at(%a: !acc, %s: !acc, %p: !p, %k: !p, %o: index) -> (!acc, !acc) {
  %po = func.call @at(%p, %o) : (!p, index) -> !p
  %ko = func.call @at(%k, %o) : (!p, index) -> !p
  %r:2 = func.call @stripe(%a, %s, %po, %ko) : (!acc, !acc, !p, !p) -> (!acc, !acc)
  return %r#0, %r#1 : !acc, !acc
}

// settle returns acc plus the products a and the swapped data s.
func.func private @settle(%acc: !acc, %a: !acc, %s: !acc) -> !acc {
  %w = func.call @swap(%s) : (!acc) -> !acc
  %x = arith.addi %a, %w : !acc
  %r = arith.addi %acc, %x : !acc
  return %r : !acc
}

// quads returns the sums of the products and of the data of the 4·nq stripes at p, with key rows
// 0 to 4·nq - 1, four stripes per loop trip.
func.func private @quads(%p: !p, %keys: !p, %nq: index) -> (!acc, !acc) {
  %c0 = arith.constant 0 : index
  %c64 = arith.constant 64 : index
  %c128 = arith.constant 128 : index
  %c192 = arith.constant 192 : index
  %c256 = arith.constant 256 : index
  %z = arith.constant dense<0> : !acc
  %end = arith.muli %nq, %c256 : index
  %t:2 = scf.for %o = %c0 to %end step %c256 iter_args(%s0 = %z, %d = %z) -> (!acc, !acc) {
    %pq = func.call @at(%p, %o) : (!p, index) -> !p
    %kq = func.call @at(%keys, %o) : (!p, index) -> !p
    %u0:2 = func.call @stripe_at(%s0, %d, %pq, %kq, %c0) : (!acc, !acc, !p, !p, index) -> (!acc, !acc)
    %u1:2 = func.call @stripe_at(%u0#0, %u0#1, %pq, %kq, %c64) : (!acc, !acc, !p, !p, index) -> (!acc, !acc)
    %u2:2 = func.call @stripe_at(%u1#0, %u1#1, %pq, %kq, %c128) : (!acc, !acc, !p, !p, index) -> (!acc, !acc)
    %u3:2 = func.call @stripe_at(%u2#0, %u2#1, %pq, %kq, %c192) : (!acc, !acc, !p, !p, index) -> (!acc, !acc)
    scf.yield %u3#0, %u3#1 : !acc, !acc
  }
  return %t#0, %t#1 : !acc, !acc
}

// blocks accumulates n blocks of 1024 bytes at p and scrambles after each. A block's sums start
// at zero, so its stripes need not wait for the scramble of the block before, and each block
// adds to the accumulator once.
func.func private @blocks(%a: !acc, %p: !p, %n: index, %keys: !p) -> !acc {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c4 = arith.constant 4 : index
  %c1024 = arith.constant 1024 : index
  %skp = func.call @at(%keys, %c1024) : (!p, index) -> !p
  %sk = func.call @lanes_load(%skp) : (!p) -> !acc
  %r = scf.for %b = %c0 to %n step %c1 iter_args(%acc = %a) -> (!acc) {
    %o = arith.muli %b, %c1024 : index
    %pb = func.call @at(%p, %o) : (!p, index) -> !p
    %y:2 = func.call @quads(%pb, %keys, %c4) : (!p, !p, index) -> (!acc, !acc)
    %x = func.call @settle(%acc, %y#0, %y#1) : (!acc, !acc, !acc) -> !acc
    %c = func.call @scramble(%x, %sk) : (!acc, !acc) -> !acc
    scf.yield %c : !acc
  }
  return %r : !acc
}

// minlz_xxh3_blocks accumulates the n blocks at p into the 8 lanes at acc, as xxh3::blocks does.
func.func @minlz_xxh3_blocks(%acc: !p, %p: !p, %n: i64, %keys: !p) {
  %ni = arith.index_cast %n : i64 to index
  %a = func.call @lanes_load(%acc) : (!p) -> !acc
  %s = func.call @blocks(%a, %p, %ni, %keys) : (!acc, !p, index, !p) -> !acc
  func.call @lanes_store(%s, %acc) : (!acc, !p) -> ()
  return
}

// minlz_xxh3_accum accumulates the len bytes at p, len ≥ 64, into the 8 lanes at acc as the end of
// the input, as xxh3::accum does: the blocks that more input follows, the whole stripes after them
// but the last, then the last 64 bytes.
func.func @minlz_xxh3_accum(%acc: !p, %p: !p, %len: i64, %keys: !p) {
  %c1 = arith.constant 1 : index
  %c64 = arith.constant 64 : index
  %c256 = arith.constant 256 : index
  %c1024 = arith.constant 1024 : index
  %c1088 = arith.constant 1088 : index
  %l = arith.index_cast %len : i64 to index
  %l1 = arith.subi %l, %c1 : index
  %n = arith.divui %l1, %c1024 : index
  %a = func.call @lanes_load(%acc) : (!p) -> !acc
  %b = func.call @blocks(%a, %p, %n, %keys) : (!acc, !p, index, !p) -> !acc
  %done = arith.muli %n, %c1024 : index
  %rest = func.call @at(%p, %done) : (!p, index) -> !p
  %rl = arith.subi %l1, %done : index
  %nq = arith.divui %rl, %c256 : index
  %q:2 = func.call @quads(%rest, %keys, %nq) : (!p, !p, index) -> (!acc, !acc)
  %from = arith.muli %nq, %c256 : index
  %ns = arith.divui %rl, %c64 : index
  %to = arith.muli %ns, %c64 : index
  %s:2 = scf.for %o = %from to %to step %c64 iter_args(%t = %q#0, %u = %q#1) -> (!acc, !acc) {
    %v:2 = func.call @stripe_at(%t, %u, %rest, %keys, %o) : (!acc, !acc, !p, !p, index) -> (!acc, !acc)
    scf.yield %v#0, %v#1 : !acc, !acc
  }
  %lo = arith.subi %l, %c64 : index
  %pl = func.call @at(%p, %lo) : (!p, index) -> !p
  %kl = func.call @at(%keys, %c1088) : (!p, index) -> !p
  %f:2 = func.call @stripe(%s#0, %s#1, %pl, %kl) : (!acc, !acc, !p, !p) -> (!acc, !acc)
  %g = func.call @settle(%b, %f#0, %f#1) : (!acc, !acc, !acc) -> !acc
  func.call @lanes_store(%g, %acc) : (!acc, !p) -> ()
  return
}
