func label_decoder(colors):
	var values = {
		"black": 0,
		"brown": 1,
		"red": 2,
		"orange": 3,
		"yellow": 4,
		"green": 5,
		"blue": 6,
		"violet": 7,
		"grey": 8,
		"gray": 8,
		"white": 9
	}

	var tolerances = {
		"grey": "0.05",
		"gray": "0.05",
		"violet": "0.1",
		"blue": "0.25",
		"green": "0.5",
		"brown": "1",
		"red": "2",
		"gold": "5",
		"silver": "10"
	}

	if colors.size() == 1:
		return "0 ohms"

	var digits = 0
	var multiplier = 0
	var tolerance = "0"

	if colors.size() == 4:
		digits = values[colors[0]] * 10 + values[colors[1]]
		multiplier = values[colors[2]]
		tolerance = tolerances[colors[3]]
	elif colors.size() == 5:
		digits = values[colors[0]] * 100 + values[colors[1]] * 10 + values[colors[2]]
		multiplier = values[colors[3]]
		tolerance = tolerances[colors[4]]

	var resistance = digits * pow(10, multiplier)
	var unit = "ohms"

	if resistance >= 1000000:
		resistance /= 1000000.0
		unit = "megaohms"
	elif resistance >= 1000:
		resistance /= 1000.0
		unit = "kiloohms"

	var result = str(int(resistance)) if resistance == int(resistance) else str(resistance)

	return result + " " + unit + " ±" + tolerance + "%"