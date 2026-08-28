package squareroot

func SquareRoot(number int) (int, error) {
	lower := 1
	upper := 256

	for {
		mid := (upper + lower) / 2
		square := mid * mid

		if square < number {
			lower = mid
		} else if square > number {
			upper = mid
		} else {
			return mid, nil
		}

		if lower >= upper-1 {
			break
		}
	}

	return lower, nil
}