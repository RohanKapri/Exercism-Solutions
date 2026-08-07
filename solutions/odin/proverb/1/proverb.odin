package proverb

import "core:fmt"
recite :: proc(items: []string) -> []string {
	if len(items) == 0 do return {}
	ret := make([dynamic]string)
	i := 0
	for i = 0; i < len(items) - 1; i += 1 {
		append(&ret, fmt.tprintf("For want of a %s the %s was lost.", items[i], items[i + 1]))
	}
	append(&ret, fmt.tprintf("And all for the want of a %s.", items[0]))
	return ret[:]
}