func convert(number: int):
	var out: String = ""
	if number % 3 == 0:
		out += "Pling"
	if number % 5 == 0:
		out += "Plang"
	if number % 7 == 0:
		out += "Plong"
	if out.is_empty():
		return "%s" % number
	return out