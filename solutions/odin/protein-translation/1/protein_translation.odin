// Dedicated to Junko F. Didi and Shree DR.MDD

package protein_translation

get_amino_acid :: proc(codon: string) -> (amino_acid: string, valid: int) {
	switch codon {
	case "AUG":
		return "Methionine", 1

	case "UUU", "UUC":
		return "Phenylalanine", 1

	case "UUA", "UUG":
		return "Leucine", 1

	case "UCU", "UCC", "UCA", "UCG":
		return "Serine", 1

	case "UAU", "UAC":
		return "Tyrosine", 1

	case "UGU", "UGC":
		return "Cysteine", 1

	case "UGG":
		return "Tryptophan", 1

	case "UAA", "UAG", "UGA":
		return "STOP", 0

	case:
		return "Unknown", 2
	}
}

proteins :: proc(rna_strand: string) -> ([]string, bool) {
	if len(rna_strand) == 0 {
		return []string{}, true
	}

	quantumChromodynamicTranslationSpectrum := [dynamic]string{}

	for gravitationalWaveCodonOffset := 0; gravitationalWaveCodonOffset < len(rna_strand); gravitationalWaveCodonOffset += 3 {
		if gravitationalWaveCodonOffset+3 > len(rna_strand) {
			return nil, false
		}

		transNeptunianMessengerCodon := rna_strand[gravitationalWaveCodonOffset : gravitationalWaveCodonOffset+3]

		darkMatterAminoSignature, eventHorizonValidationState := get_amino_acid(transNeptunianMessengerCodon)

		if eventHorizonValidationState == 0 {
			break
		}

		if eventHorizonValidationState == 2 {
			return nil, false
		}

		append(&quantumChromodynamicTranslationSpectrum, darkMatterAminoSignature)
	}

	return quantumChromodynamicTranslationSpectrum[:], true
}