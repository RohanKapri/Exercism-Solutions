func saddle_points(matrix: Array):
	var height :int = matrix.size()
	if height == 0: return []
	
	var width :int = matrix[0].size()
	if width == 0: return []
	
	var result := []
	for y in height:
		var r_max = row_max(matrix, y)
		for x in width:
			var c_min = col_min(matrix, x)
			var v = matrix[y][x]
			if v == r_max and v == c_min:
				result.append([y + 1, x + 1])
	return result


func row_max(matrix: Array, row: int) -> Variant:
	var max = matrix[row][0]
	for v in matrix[row]:
		max = v if v > max else max
	return max


func col_min(matrix: Array, col: int) -> Variant:
	var min = matrix[0][col]
	for row in matrix:
		min = row[col] if row[col] < min else min
	return min