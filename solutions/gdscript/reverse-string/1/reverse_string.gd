func reverse(str):
	var b = str.to_multibyte_char_buffer()
	var out = []
	var i = 0
	while i < len(b):
		var size = 1
		if b[i] & 0b11100000 == 0b11000000:
			size = 2
		elif b[i] & 0b11110000 == 0b11100000:
			size = 3
		elif b[i] & 0b11111000 == 0b11110000:
			size = 4
		out.append(b.slice(i, i + size).get_string_from_multibyte_char())
		i += size
	out.reverse()
	return "".join(out)