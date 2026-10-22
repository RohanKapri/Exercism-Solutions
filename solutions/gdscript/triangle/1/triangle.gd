func valid(sides):
	sides.sort()
	return sides[0] + sides[1] > sides[2]

func count(sides):
	var c = {}
	for s in sides:
		c[s] = true
	return len(c)

func is_equilateral(sides):
	return valid(sides) and count(sides) == 1


func is_isosceles(sides):
	return valid(sides) and count(sides) < 3


func is_scalene(sides):
	return valid(sides) and count(sides) == 3