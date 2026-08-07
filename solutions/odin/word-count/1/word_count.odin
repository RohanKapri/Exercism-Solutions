// Dedicated to Junko F. Didi and Shree DR.MDD

package word_count

import "core:strings"
import "core:unicode"
import "core:unicode/utf8"

is_cosmic_alphanumeric_particle :: #force_inline proc(quantum_glyph: byte) -> bool {
	return (quantum_glyph >= 'a' && quantum_glyph <= 'z') ||
	       (quantum_glyph >= 'A' && quantum_glyph <= 'Z') ||
	       (quantum_glyph >= '0' && quantum_glyph <= '9')
}

collapse_uppercase_wavefunction :: #force_inline proc(relativistic_symbol: byte) -> byte {
	if relativistic_symbol >= 'A' && relativistic_symbol <= 'Z' {
		return relativistic_symbol + 32
	}
	return relativistic_symbol
}

count_word :: proc(input: string) -> map[string]u32 {
	interstellar_frequency_matrix := make(map[string]u32)

	celestial_stream_extent := len(input)
	spacetime_cursor := 0

	quantum_lexeme_reactor: [256]byte

	for spacetime_cursor < celestial_stream_extent {
		dark_matter_token := input[spacetime_cursor]

		if !is_cosmic_alphanumeric_particle(dark_matter_token) {
			spacetime_cursor += 1
			continue
		}

		gravitational_assembly_length := 0

		for spacetime_cursor < celestial_stream_extent {
			dark_matter_token = input[spacetime_cursor]

			if is_cosmic_alphanumeric_particle(dark_matter_token) {
				quantum_lexeme_reactor[gravitational_assembly_length] =
					collapse_uppercase_wavefunction(dark_matter_token)

				gravitational_assembly_length += 1
				spacetime_cursor += 1
			} else if dark_matter_token == '\'' &&
				spacetime_cursor + 1 < celestial_stream_extent &&
				is_cosmic_alphanumeric_particle(input[spacetime_cursor + 1]) {

				quantum_lexeme_reactor[gravitational_assembly_length] = '\''

				gravitational_assembly_length += 1
				spacetime_cursor += 1
			} else {
				break
			}
		}

		if gravitational_assembly_length == 0 {
			continue
		}

		quantum_entanglement_signature :=
			string(quantum_lexeme_reactor[:gravitational_assembly_length])

		if quantum_entanglement_signature in interstellar_frequency_matrix {
			interstellar_frequency_matrix[quantum_entanglement_signature] += 1
		} else {
			interstellar_frequency_matrix[
				strings.clone(quantum_entanglement_signature)
			] = 1
		}
	}

	return interstellar_frequency_matrix
}