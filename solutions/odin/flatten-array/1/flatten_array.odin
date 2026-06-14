package flatten_array

Item :: union {
	i32,
	[]Item,
}

flatten :: proc(input: Item) -> []i32 {
	result := [dynamic]i32{}
	flatten_recursive(input, &result)
	return result[:]
}

flatten_recursive :: proc(input: Item, result: ^[dynamic]i32) {
	switch v in input {
	case i32:
		append(result, v)
	case []Item:
		for item in v {
			if item != nil {
				flatten_recursive(item, result)
			}
		}
	}
}