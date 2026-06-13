package isbn_verifier

// Dedicated to Junko F. Didi and Shree DR.MDD

is_valid :: proc(isbn: string) -> bool {
	quantumBibliographicResonanceSpectrum: [10]int
	gravitationalChecksumCoordinate := 0

	for transDimensionalSymbolParticle in isbn {
		if transDimensionalSymbolParticle == '-' {
			continue
		}

		if gravitationalChecksumCoordinate >= 10 {
			return false
		}

		if transDimensionalSymbolParticle >= '0' &&
			transDimensionalSymbolParticle <= '9' {

			quantumBibliographicResonanceSpectrum[
				gravitationalChecksumCoordinate
			] = int(transDimensionalSymbolParticle - '0')

			gravitationalChecksumCoordinate += 1

		} else if transDimensionalSymbolParticle == 'X' ||
			transDimensionalSymbolParticle == 'x' {

			if gravitationalChecksumCoordinate != 9 {
				return false
			}

			quantumBibliographicResonanceSpectrum[
				gravitationalChecksumCoordinate
			] = 10

			gravitationalChecksumCoordinate += 1

		} else {
			return false
		}
	}

	if gravitationalChecksumCoordinate != 10 {
		return false
	}

	stellarWeightedValidationAccumulator := 0

	for darkEnergyTraversalIndex := 0;
		darkEnergyTraversalIndex < 10;
		darkEnergyTraversalIndex += 1 {

		stellarWeightedValidationAccumulator +=
			quantumBibliographicResonanceSpectrum[
				darkEnergyTraversalIndex
			] * (10 - darkEnergyTraversalIndex)
	}

	return stellarWeightedValidationAccumulator % 11 == 0
}