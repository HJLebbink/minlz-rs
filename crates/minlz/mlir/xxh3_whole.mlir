// Lane layout for fixed-width vectors: the accumulator lanes in memory order, !acc being
// vector<8xi64>.

// lanes_load returns the 8 lanes at p.
func.func private @lanes_load(%p: !p) -> !acc {
  %r = ptr.load %p alignment = 1 : !p -> !acc
  return %r : !acc
}

// lanes_store writes the 8 lanes of a to p.
func.func private @lanes_store(%a: !acc, %p: !p) {
  ptr.store %a, %p alignment = 8 : !acc, !p
  return
}

// swap returns a with neighboring lanes exchanged.
func.func private @swap(%a: !acc) -> !acc {
  %r = vector.shuffle %a, %a [1, 0, 3, 2, 5, 4, 7, 6] : !acc, !acc
  return %r : !acc
}
