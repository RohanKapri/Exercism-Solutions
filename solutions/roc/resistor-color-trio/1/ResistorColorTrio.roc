ResistorColorTrio :: {}.{
	Color : [
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
	],

	Label : [Ohms(U16), Kiloohms(U16), Megaohms(U16), Gigaohms(U16)],

	label : Color, Color, Color -> Label
	label = |first, second, third| {
		c1 = color_to_num(first)
		c2 = color_to_num(second)
		zeros = color_to_num(third)

		# Calculate base resistance as U64 to prevent intermediate overflow
		total_value = (c1 * 10 + c2) * pow10(zeros)

		if total_value >= 1_000_000_000 && total_value % 1_000_000_000 == 0 then
			Gigaohms(Num.to_u16(total_value // 1_000_000_000))
		else if total_value >= 1_000_000 && total_value % 1_000_000 == 0 then
			Megaohms(Num.to_u16(total_value // 1_000_000))
		else if total_value >= 1_000 && total_value % 1_000 == 0 then
			Kiloohms(Num.to_u16(total_value // 1_000))
		else
			Ohms(Num.to_u16(total_value))
	}
}

color_to_num : [Black, Brown, Red, Orange, Yellow, Green, Blue, Violet, Grey, White] -> U64
color_to_num = |color|
	when color is
		Black -> 0
		Brown -> 1
		Red -> 2
		Orange -> 3
		Yellow -> 4
		Green -> 5
		Blue -> 6
		Violet -> 7
		Grey -> 8
		White -> 9

pow10 : U64 -> U64
pow10 = |exp|
	when exp is
		0 -> 1
		1 -> 10
		2 -> 100
		3 -> 1_000
		4 -> 10_000
		5 -> 100_000
		6 -> 1_000_000
		7 -> 10_000_000
		8 -> 100_000_000
		9 -> 1_000_000_000
		_ -> 1