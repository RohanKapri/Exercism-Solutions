func score(x, y):
	var d = x * x + y * y
	if d > 100:
		return 0
	if d > 25:
		return 1
	if d > 1:
		return 5
	return 10