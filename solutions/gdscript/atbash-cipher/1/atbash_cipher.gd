const letters = "abcdefghijklmnopqrstuvwxyz"
const digits = "0123456789"

func encode(plain_text):
	var raw: String = decode(plain_text)
	var parts: Array = []
	for i in range(0, len(raw), 5):
		parts.append(raw.substr(i, 5))
	return " ".join(parts)


func decode(ciphered_text):
	var cipher = {}
	for i in range(len(letters)):
		cipher[letters[i]] = letters[len(letters) - i - 1]
	var out: String = ""
	for i in ciphered_text.to_lower():
		if i in digits:
			out += i
		elif i in letters:
			out += cipher[i]
	return out