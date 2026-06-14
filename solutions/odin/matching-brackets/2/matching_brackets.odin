package matching_brackets

is_balanced :: proc(input: string) -> bool {
	stack := make([dynamic]rune)
	defer delete(stack)
    

	Pair :: struct {
		key, value: rune,
	}

	find_pair :: proc(p: [3]Pair, key, value: rune) -> bool {
		for e in p {
			if e.key == key && e.value == value do return true
		}
		return false
	}

	PAIRS := [3]Pair{{')', '('}, {']', '['}, {'}', '{'}}

	for e in input {
		switch e {
		case '(', '{', '[':
			append(&stack, e)
		case ')', '}', ']':
			top, ok := pop_safe(&stack)
			if !ok do return false
			if !find_pair(PAIRS, e, top) do return false
		case:
			continue
		}
	}
	return len(stack) == 0
}