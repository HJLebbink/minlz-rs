// Target file for 256-bit SVE (vscale 2): the 8 accumulator lanes span two registers, and each
// half of the split layout one. At any other vector length !acc is not 8 lanes.

!acc = vector<[4]xi64>
!h = vector<[2]xi64>

// halves returns the two halves of a.
func.func private @halves(%a: !acc) -> (!h, !h) {
  %e = vector.scalable.extract %a[0] : !h from !acc
  %o = vector.scalable.extract %a[2] : !h from !acc
  return %e, %o : !h, !h
}

// join returns the value whose halves are e and o.
func.func private @join(%e: !h, %o: !h) -> !acc {
  %z = ub.poison : !acc
  %a = vector.scalable.insert %e, %z[0] : !h into !acc
  %r = vector.scalable.insert %o, %a[2] : !h into !acc
  return %r : !acc
}

// lohi returns the product of the low and the high 32-bit half of each lane of x.
func.func private @lohi(%x: !acc) -> !acc {
  %lo32 = arith.constant dense<4294967295> : !acc
  %c32 = arith.constant dense<32> : !acc
  %l = arith.andi %x, %lo32 : !acc
  %h = arith.shrui %x, %c32 : !acc
  %r = arith.muli %l, %h : !acc
  return %r : !acc
}
