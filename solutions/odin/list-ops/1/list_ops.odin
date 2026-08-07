package list_ops

ls_append :: proc(l: []$T, other: []T) -> []T {
	new := [dynamic]T{}
	append(&new, ..l)
	append(&new, ..other)
	return new[:]
}

ls_concat :: proc(lists: [][]$T) -> []T {
	new := [dynamic]T{}
	for l in lists {
		append(&new, ..l)
	}
	return new[:]
}

ls_filter :: proc(l: []$T, pred: proc(element: T) -> bool) -> []T {
	new := [dynamic]T{}

	for element in l {
		if pred(element) {
			append(&new, element)
		}
	}

	return new[:]
}

ls_length :: proc(l: []$T) -> int {
	return len(l)
}

ls_map :: proc(l: []$T, transform: proc(element: T) -> $U) -> []U {
	new := [dynamic]U{}

	for element in l {
		append(&new, transform(element))
	}

	return new[:]
}

ls_foldl :: proc(l: []$T, initial_value: $U, fn: proc(acc: U, element: T) -> U) -> U {
	value := initial_value
	for element in l {
		value = fn(value, element)
	}
	return value
}

ls_foldr :: proc(l: []$T, initial_value: $U, fn: proc(acc: U, element: T) -> U) -> U {
	value := initial_value
	#reverse for element in l {
		value = fn(value, element)
	}
	return value
}

ls_reverse :: proc(l: []$T) -> []T {
	new := [dynamic]T{}
	#reverse for element in l {
		append(&new, element)
	}
	return new[:]
}