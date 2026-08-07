package rna_transcription

import "core:strings"

to_rna :: proc(dna: string) -> (rna: string, ok: bool) {
	builder := strings.builder_make()

	for char in dna {
		switch char {
		case 'G':
			strings.write_rune(&builder, 'C')
		case 'C':
			strings.write_rune(&builder, 'G')
		case 'T':
			strings.write_rune(&builder, 'A')
		case 'A':
			strings.write_rune(&builder, 'U')
		case:
			// Invalid nucleotide
			strings.builder_destroy(&builder)
			return "", false
		}
	}

	return strings.to_string(builder), true
}