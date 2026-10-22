func egg_count(display_value: int) -> int:
	var out: int = 0
	while display_value > 0:
		if display_value & 1 == 1:
			out += 1
		display_value >>= 1
	return out