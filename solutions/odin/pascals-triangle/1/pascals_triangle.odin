package pascals_triangle

rows :: proc(count: int) -> [][]u128 {
	if count == 0 {
		return make([][]u128, 0)
	}
	result := make([][]u128, count)
	for i in 0..<count {
		row := make([]u128, i+1)
		row[0] = 1
		if i > 0 {
			row[i] = 1
			prev_row := result[i-1]
			for j in 1..<i {
				row[j] = prev_row[j-1] + prev_row[j]
			}
		}
		result[i] = row
	}
	return result
}