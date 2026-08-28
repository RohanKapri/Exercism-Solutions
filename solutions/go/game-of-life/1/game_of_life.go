package gameoflife

func at(matrix [][]int, x, y int) int {
	if y < 0 || y >= len(matrix) || x < 0 || x >= len(matrix[0]) {
		return 0
	}
	return matrix[y][x]
}

func neighbors(matrix [][]int, x, y int) int {
	count := 0
	for dx := -1; dx <= 1; dx++ {
		for dy := -1; dy <= 1; dy++ {
			if dx != 0 || dy != 0 {
				count += at(matrix, x+dx, y+dy)
			}
		}
	}
	return count
}

func Tick(matrix [][]int) [][]int {
	next := make([][]int, len(matrix))
	for i := range matrix {
		next[i] = make([]int, len(matrix[i]))
		copy(next[i], matrix[i])
	}

	for y := 0; y < len(matrix); y++ {
		for x := 0; x < len(matrix[0]); x++ {
			neighborCount := neighbors(matrix, x, y)
			current := at(matrix, x, y)

			if current == 1 && (neighborCount <= 1 || neighborCount >= 4) {
				next[y][x] = 0
			}
			if current == 0 && neighborCount == 3 {
				next[y][x] = 1
			}
		}
	}
	return next
}