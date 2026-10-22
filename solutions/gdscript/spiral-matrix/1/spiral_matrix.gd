func spiral_matrix(size):
	# Create n*n empty matrix
	var matrix = []
	for i in range(size):
		var row = []
		for j in range(size):
			row.append(-1)
		matrix.append(row)
	
	var pos = Vector2i(0, 0)
	var dir = Vector2i(1, 0)

	# Spiral inwards
	for i in range(size * size):
		matrix[pos.y][pos.x] = i + 1
		var n = pos + dir
		# Rotate at edges or when a cell is populated.
		if n.x >= size or n.y >= size or n.x < 0 or n.y < 0 or matrix[n.y][n.x] != -1:
			dir = Vector2i(Vector2(dir).rotated(PI / 2))
		pos += dir
	return matrix