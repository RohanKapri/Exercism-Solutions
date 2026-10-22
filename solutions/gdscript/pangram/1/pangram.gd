func is_pangram(sentence):
	sentence = sentence.to_lower()
	for i in "qwertyuiopasdfghjklzxcvbnm":
		if i not in sentence:
			return false
	return true