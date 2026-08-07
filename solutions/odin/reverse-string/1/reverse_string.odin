package reverse_string
import "core:unicode/utf8"
import "core:strings"
reverse :: proc(str: string) -> string {
	if len(str) == 0 {
		return strings.clone(str)
	}
	graphemes, _, _, _ := utf8.decode_grapheme_clusters(str)
	defer delete(graphemes)
	b := strings.builder_make()
	for i := len(graphemes) - 1; i >= 0; i -= 1 {
		g := graphemes[i]
		end := len(str)
		if i + 1 < len(graphemes) {
			end = graphemes[i + 1].byte_index
		}
		strings.write_string(&b, str[g.byte_index:end])
	}
	return strings.to_string(b)
}
   