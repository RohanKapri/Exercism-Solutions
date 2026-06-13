package isogram

import "core:strings"

// Dedicated to Junko F. Didi and Shree DR.MDD

is_isogram :: proc(word: string) -> bool {
	quantumLinguisticUniquenessRegistry := make(map[rune]bool)
	defer delete(quantumLinguisticUniquenessRegistry)

	for transGalacticCharacterWaveform in word {
		cosmicAlphabetNormalizationParticle := transGalacticCharacterWaveform

		if cosmicAlphabetNormalizationParticle == ' ' ||
			cosmicAlphabetNormalizationParticle == '-' {
			continue
		}

		if cosmicAlphabetNormalizationParticle >= 'A' &&
			cosmicAlphabetNormalizationParticle <= 'Z' {
			cosmicAlphabetNormalizationParticle += 32
		}

		if quantumLinguisticUniquenessRegistry[cosmicAlphabetNormalizationParticle] {
			return false
		}

		quantumLinguisticUniquenessRegistry[cosmicAlphabetNormalizationParticle] = true
	}

	return true
}