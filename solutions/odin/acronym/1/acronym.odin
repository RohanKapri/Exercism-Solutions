package acronym
import "core:strings"
abbreviate :: proc(phrase: string) -> string {
	result := strings.builder_make()
	start_of_word := true
	for r in phrase {
		if r == ' ' || r == '-' {
			start_of_word = true
			continue
		}
		ch := r
		if ch >= 'A' && ch <= 'Z' {
			ch = ch + ('a' - 'A')
		}
		if ch >= 'a' && ch <= 'z' {
			if start_of_word {
				strings.write_rune(&result, ch - ('a' - 'A'))
				start_of_word = false
			}
		}
	}
	return strings.to_string(result)
}