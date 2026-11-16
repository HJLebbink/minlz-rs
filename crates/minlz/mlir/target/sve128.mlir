// Target file for 128-bit SVE (vscale 1): the 8 accumulator lanes span four registers, and each
// half of the split layout two. At any other vector length !acc is not 8 lanes.

!acc = vector<[8]xi64>
!h = vector<[4]xi64>

// halves returns the two halves of a.
func.func private @halves(%a: !acc) -> (!h, !h) {
  %e = vector.scalable.extract %a[0] : !h from !acc
  %o = vector.scalable.extract %a[4] : !h from !acc
  return %e, %o : !h, !h
}

// join returns the value whose halves are e and o.
func.func private @join(%e: !h, %o: !h) -> !acc {
  %z = ub.poison : !acc
  %a = vector.scalable.insert %e, %z[0] : !h into !acc
  %r = vector.scalable.insert %o, %a[4] : !h into !acc
  return %r : !acc
}
