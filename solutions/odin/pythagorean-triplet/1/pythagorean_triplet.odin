package pythagorean_triplet

Triplet :: struct {
	a, b, c: int,
}

triplets_with_sum :: proc(n: int) -> []Triplet {
	result: [dynamic]Triplet
	
	for a in 1 ..< n {
		for b in a + 1 ..< n - a {
			c := n - a - b
			if c <= b {
				continue
			}
			if a * a + b * b == c * c {
				append(&result, Triplet{a, b, c})
			}
		}
	}
	
	return result[:]
}