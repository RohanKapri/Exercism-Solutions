package difference_of_squares

square_of_sum :: proc(n: int) -> int {
	result := 0
	for i := 1; i <= n; i += 1 {
		result += i
	}
	return result * result
}

sum_of_squares :: proc(n: int) -> int {
	result := 0
	for i := 1; i <= n; i += 1 {
		result += (i * i)
	}
	return result
}

difference :: proc(n: int) -> int {
	// Implement this procedure.
	return square_of_sum(n) - sum_of_squares(n)
}