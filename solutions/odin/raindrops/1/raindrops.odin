package raindrops

import "core:fmt"
import "core:strings"

convert :: proc(number: int) -> string {
	// 1. Initialize a builder on the stack
	sb: strings.Builder
	strings.builder_init(&sb, context.temp_allocator)

	// 2. Check conditions and write directly to the buffer
	if number % 3 == 0 do strings.write_string(&sb, "Pling")
	if number % 5 == 0 do strings.write_string(&sb, "Plang")
	if number % 7 == 0 do strings.write_string(&sb, "Plong")

	// 3. If nothing was written, return the number as a string
	if strings.builder_len(sb) == 0 {
		return fmt.tprint(number)
	}

	// 4. Return the resulting string (stored in the temp_allocator)
	return strings.to_string(sb)
}