package two_fer

import "core:fmt"
two_fer :: proc(name: string = "you") -> string {
	return fmt.tprint("One for ", name, ", one for me.", sep = "")
}