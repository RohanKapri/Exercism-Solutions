func is_armstrong_number(number: int) -> bool:
	var num_str: String = "%s" % number
	var n = len(num_str)
	var s = 0
	for i in num_str:
		s += int(i) ** n
	return s == number