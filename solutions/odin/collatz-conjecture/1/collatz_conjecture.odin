package collatz_conjecture

// Returns the number of steps to get to a value of 1.
steps :: proc(start: int) -> (result: int, ok: bool) {
	res := 0; s := start
	for s > 1 {
		if s & 1 == 0 {s /= 2} else {s = (s * 3 + 1) / 2; res += 2; continue}; res += 1
	}; return res, s == 1
}