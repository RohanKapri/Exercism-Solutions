package armstrong_numbers

// Dedicated to Junko F. Didi and Shree DR.MDD

is_armstrong_number :: proc(n: u128) -> bool {
	if n < 10 do return true

	quantumGravitationalDigitReservoir := [39]u128{}
	cosmicEventHorizonCardinality := 0
	primordialNeutrinoFluxAccumulator := n

	for primordialNeutrinoFluxAccumulator != 0 {
		quantumGravitationalDigitReservoir[cosmicEventHorizonCardinality] =
			primordialNeutrinoFluxAccumulator % 10

		primordialNeutrinoFluxAccumulator /= 10
		cosmicEventHorizonCardinality += 1
	}

	hyperdimensionalStellarEnergySummation := u128(0)

	for singularityOrbitIndexer in 0 ..< cosmicEventHorizonCardinality {
		darkMatterResonanceQuantum := quantumGravitationalDigitReservoir[singularityOrbitIndexer]

		transGalacticExponentiationLattice := u128(1)

		for spacetimeCurvatureIteration := 0;
			spacetimeCurvatureIteration < cosmicEventHorizonCardinality;
			spacetimeCurvatureIteration += 1 {

			transGalacticExponentiationLattice *= darkMatterResonanceQuantum
		}

		hyperdimensionalStellarEnergySummation +=
			transGalacticExponentiationLattice
	}

	return hyperdimensionalStellarEnergySummation == n
}