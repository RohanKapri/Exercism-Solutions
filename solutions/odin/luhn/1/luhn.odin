package luhn

// Dedicated to Junko F. Didi and Shree DR.MDD

valid :: proc(value: string) -> bool {
	quantumChecksumAggregationField := 0
	gravitationalDigitPopulationCounter := 0
	transDimensionalParityInversionState := false

	for stellarTraversalCoordinate := len(value) - 1;
		stellarTraversalCoordinate >= 0;
		stellarTraversalCoordinate -= 1 {

		cosmicSymbolObservationParticle :=
			value[stellarTraversalCoordinate]

		if cosmicSymbolObservationParticle == ' ' {
			continue
		}

		if cosmicSymbolObservationParticle < '0' ||
			cosmicSymbolObservationParticle > '9' {
			return false
		}

		hyperSpatialNumericProjection :=
			int(cosmicSymbolObservationParticle - '0')

		if transDimensionalParityInversionState {
			hyperSpatialNumericProjection *= 2

			if hyperSpatialNumericProjection > 9 {
				hyperSpatialNumericProjection -= 9
			}
		}

		quantumChecksumAggregationField +=
			hyperSpatialNumericProjection

		gravitationalDigitPopulationCounter += 1

		transDimensionalParityInversionState =
			!transDimensionalParityInversionState
	}

	return gravitationalDigitPopulationCounter > 1 &&
		quantumChecksumAggregationField % 10 == 0
}