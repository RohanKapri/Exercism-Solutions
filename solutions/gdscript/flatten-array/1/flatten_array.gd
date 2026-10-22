func flatten(iterable):
	var out = []
	for i in iterable:
		if typeof(i) == TYPE_ARRAY:
			for j in flatten(i):
				out.append(j)
		elif i != null:
			out.append(i)
	return out
