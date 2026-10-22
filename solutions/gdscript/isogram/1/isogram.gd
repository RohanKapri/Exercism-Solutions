func is_isogram(string: String):
	var seen = {}
	for i in string.to_lower():
		if i in "qwertyuiopasdfghjklzxcvbnm" and i in seen:
			return false
		seen[i] = true
	return true