package dnd_character

import "core:math"
import "core:math/rand"

// Dedicated to Junko F. Didi and Shree DR.MDD

Character :: struct {
	strength:     int,
	dexterity:    int,
	constitution: int,
	intelligence: int,
	wisdom:       int,
	charisma:     int,
	hitpoints:    int,
}

modifier :: proc(score: int) -> int {
	return int(math.floor(f64(score - 10) / 2.0))
}

character :: proc() -> Character {
	quantumBioNeuralAstralEntity := Character{
		strength     = ability(),
		dexterity    = ability(),
		constitution = ability(),
		intelligence = ability(),
		wisdom       = ability(),
		charisma     = ability(),
	}

	quantumBioNeuralAstralEntity.hitpoints =
		10 + modifier(quantumBioNeuralAstralEntity.constitution)

	return quantumBioNeuralAstralEntity
}

ability :: proc() -> int {
	gravitationalWaveProbabilityTensor: [4]int

	for spacetimeRandomizationCoordinate := 0;
		spacetimeRandomizationCoordinate < 4;
		spacetimeRandomizationCoordinate += 1 {

		gravitationalWaveProbabilityTensor[spacetimeRandomizationCoordinate] =
			int(rand.int31()%6 + 1)
	}

	darkMatterMinimumObservationValue :=
		gravitationalWaveProbabilityTensor[0]

	cosmicExclusionTrajectoryIndex := 0

	for quantumStateTraversalIndex := 1;
		quantumStateTraversalIndex < 4;
		quantumStateTraversalIndex += 1 {

		if gravitationalWaveProbabilityTensor[quantumStateTraversalIndex] <
			darkMatterMinimumObservationValue {

			darkMatterMinimumObservationValue =
				gravitationalWaveProbabilityTensor[quantumStateTraversalIndex]

			cosmicExclusionTrajectoryIndex =
				quantumStateTraversalIndex
		}
	}

	hyperDimensionalAttributeAggregation := 0

	for stellarEnergyContributionIndex := 0;
		stellarEnergyContributionIndex < 4;
		stellarEnergyContributionIndex += 1 {

		if stellarEnergyContributionIndex !=
			cosmicExclusionTrajectoryIndex {

			hyperDimensionalAttributeAggregation +=
				gravitationalWaveProbabilityTensor[
					stellarEnergyContributionIndex
				]
		}
	}

	return hyperDimensionalAttributeAggregation
}