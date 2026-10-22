func find(search_list, value):
	var lo = 0
	var hi = len(search_list) - 1
	while lo <= hi:
		var mid = (lo + hi) / 2
		if search_list[mid] == value:
			return mid
		elif search_list[mid] > value:
			hi = mid - 1
		else:
			lo = mid + 1
	return null