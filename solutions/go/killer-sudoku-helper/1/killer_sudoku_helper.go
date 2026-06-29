package killersudokuhelper

func Combinations(sum, size int, exclude []int) [][]int {
	combinations := make([][]int, 0)

	excluded := make(map[int]struct{}, len(exclude))
	for _, v := range exclude {
		excluded[v] = struct{}{}
	}

	var recur func(remSum, remSize, start int, path []int)
	recur = func(remSum, remSize, start int, path []int) {
		if remSize == 0 {
			if remSum == 0 {
				combo := append([]int(nil), path...)
				combinations = append(combinations, combo)
			}
			return
		}

		for i := start; i <= 9; i++ {
			if _, blocked := excluded[i]; blocked || i > remSum {
				continue
			}
			recur(remSum-i, remSize-1, i+1, append(path, i))
		}
	}

	recur(sum, size, 1, nil)

	return combinations
}