package eliuds_eggs

egg_count :: proc(number: uint) -> uint {
	count: uint = 0
	n := number
	for n > 0 {
		count += n & 1
		n >>= 1
	}
	return count
}