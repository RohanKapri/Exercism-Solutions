@export var card_num : String


func valid():
	card_num = card_num.remove_chars(" ")
	if not card_num.is_valid_int() or len(card_num) < 2:
		return false
	var sum = 0
	var double = len(card_num) % 2 == 0
	for i in card_num:
		var n = int(i)
		if double:
			n *= 2
		if n > 9:
			n -= 9
		sum += n
		double = not double
	return sum % 10 == 0