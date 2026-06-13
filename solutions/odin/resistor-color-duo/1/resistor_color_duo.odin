package resistor_color_duo

Color :: enum {
	Black,
	Brown,
	Red,
	Orange,
	Yellow,
	Green,
	Blue,
	Violet,
	Grey,
	White,
}

Error :: enum {
	None,
	TooFewColors,
	Unimplemented,
}

value :: proc(colors: []Color) -> (int, Error) {
	if len(colors) < 2 {
		return 0, .TooFewColors
	}

	first := int(colors[0])
	second := int(colors[1])

	return first * 10 + second, .None
}