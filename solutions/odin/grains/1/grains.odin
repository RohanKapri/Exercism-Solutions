package grains

Error :: enum {
	None = 0,
	InvalidSquare,
	Unimplemented,
}

// Returns the number of grains on the specified square.
square :: proc(n: int) -> (u64, Error) {
	if n < 1 || n > 64 {
		return 0, .InvalidSquare
	}
	return 1 << uint(n - 1), .None
}

// Returns the total number of squares on the board.
total :: proc() -> (u64, Error) {
	return max(u64), .None
}