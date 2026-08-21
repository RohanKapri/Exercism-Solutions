LineUp :: {}.{
	format : Str, U64 -> Str
	format = |name, rank| {
		"${name}, you are the ${rank.to_str()}${ending(rank)} customer we serve today. Thank you!"
	}

	ending = |number| {
	    if number % 10 == 1 and number % 100 != 11 {
			"st"
		}
		else if number % 10 == 2 and number % 100 != 12 {
		    "nd"
		}
		else if number % 10 == 3 and number % 100 != 13 {
		    "rd"
		}
		else {
		    "th"
		}
	}
}