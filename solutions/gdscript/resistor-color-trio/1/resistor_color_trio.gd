var COLORS = ["black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"]
var UNITS = ["ohms", "kiloohms", "megaohms", "gigaohms"]


func label(colors):
	"""Return the value of a resistor color."""
	var val = 0
	for color in colors.slice(0, 2):
		val = val * 10 + COLORS.find(color)
	val *= 10 ** COLORS.find(colors[2])

	var power = 0
	while val > 1000 and not val % 1000:
		val /= 1000
		power += 1
	return "%s %s" % [val, UNITS[power]]