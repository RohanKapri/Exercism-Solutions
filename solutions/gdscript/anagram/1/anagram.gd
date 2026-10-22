func canonical(word):
	var letters = word.to_lower().split()
	letters.sort()
	return "".join(letters)

func find_anagram(word, candidates):
	word = word.to_lower()
	var target = canonical(word)
	var anagrams = []
	for candidate in candidates:
		if candidate.to_lower() != word and canonical(candidate) == target:
			anagrams.append(candidate)
	return anagrams