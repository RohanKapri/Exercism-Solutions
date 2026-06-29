package eliudseggs

func EggCount(displayValue int) int {
	count := 0
	for displayValue > 0 {
		count += displayValue % 2
		displayValue >>= 1
	}
	return count
}