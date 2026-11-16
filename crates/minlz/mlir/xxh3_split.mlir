// Lane layout for SVE: the accumulator lanes de-interleaved. The first half of !acc holds lanes 0,
// 2, 4 and 6, the second half lanes 1, 3, 5 and 7. LD2D and ST2D split and join them, and a swap
// of neighboring lanes exchanges the halves. The target file gives !h, the type of a half, and
// @halves and @join.

// lanes_load returns the 8 lanes at p.
func.func private @lanes_load(%p: !p) -> !acc {
  %w = ptr.load %p alignment = 1 : !p -> !acc
  %e, %o = vector.deinterleave %w : !acc -> !h
  %r = func.call @join(%e, %o) : (!h, !h) -> !acc
  return %r : !acc
}

// lanes_store writes the 8 lanes of a to p.
func.func private @lanes_store(%a: !acc, %p: !p) {
  %h:2 = func.call @halves(%a) : (!acc) -> (!h, !h)
  %w = vector.interleave %h#0, %h#1 : !h -> !acc
  ptr.store %w, %p alignment = 8 : !acc, !p
  return
}

// swap returns a with neighboring lanes exchanged.
func.func private @swap(%a: !acc) -> !acc {
  %h:2 = func.call @halves(%a) : (!acc) -> (!h, !h)
  %r = func.call @join(%h#1, %h#0) : (!h, !h) -> !acc
  return %r : !acc
}
