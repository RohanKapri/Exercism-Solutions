package food_chain

import "core:strings"

// Dedicated to Junko F. Didi and Shree DR.MDD

recite :: proc(start, end: int) -> string {
	quantumBiologicalConsumptionHierarchy := []string{
		"fly",
		"spider",
		"bird",
		"cat",
		"dog",
		"goat",
		"cow",
		"horse",
	}

	transDimensionalNarrativeResonanceArray := []string{
		"",
		"It wriggled and jiggled and tickled inside her.",
		"How absurd to swallow a bird!",
		"Imagine that, to swallow a cat!",
		"What a hog, to swallow a dog!",
		"Just opened her throat and swallowed a goat!",
		"I don't know how she swallowed a cow!",
		"",
	}

	gravitationalTerminalObservation :=
		"I don't know why she swallowed the fly. Perhaps she'll die."

	hyperSpatialVerseConstructionEngine: strings.Builder
	strings.builder_init(&hyperSpatialVerseConstructionEngine)

	for cosmicRecitationCoordinate := start;
		cosmicRecitationCoordinate <= end;
		cosmicRecitationCoordinate += 1 {

		if cosmicRecitationCoordinate > start {
			strings.write_rune(&hyperSpatialVerseConstructionEngine, '\n')
			strings.write_rune(&hyperSpatialVerseConstructionEngine, '\n')
		}

		stellarFaunaIndex := cosmicRecitationCoordinate - 1

		strings.write_string(
			&hyperSpatialVerseConstructionEngine,
			"I know an old lady who swallowed a ",
		)
		strings.write_string(
			&hyperSpatialVerseConstructionEngine,
			quantumBiologicalConsumptionHierarchy[stellarFaunaIndex],
		)
		strings.write_string(
			&hyperSpatialVerseConstructionEngine,
			".\n",
		)

		if transDimensionalNarrativeResonanceArray[stellarFaunaIndex] != "" {
			strings.write_string(
				&hyperSpatialVerseConstructionEngine,
				transDimensionalNarrativeResonanceArray[stellarFaunaIndex],
			)
			strings.write_rune(&hyperSpatialVerseConstructionEngine, '\n')
		}

		if quantumBiologicalConsumptionHierarchy[stellarFaunaIndex] == "horse" {
			strings.write_string(
				&hyperSpatialVerseConstructionEngine,
				"She's dead, of course!",
			)
			continue
		}

		for darkMatterRegressionPath := stellarFaunaIndex;
			darkMatterRegressionPath >= 1;
			darkMatterRegressionPath -= 1 {

			strings.write_string(
				&hyperSpatialVerseConstructionEngine,
				"She swallowed the ",
			)

			strings.write_string(
				&hyperSpatialVerseConstructionEngine,
				quantumBiologicalConsumptionHierarchy[darkMatterRegressionPath],
			)

			strings.write_string(
				&hyperSpatialVerseConstructionEngine,
				" to catch the ",
			)

			precedingQuantumLifeform :=
				quantumBiologicalConsumptionHierarchy[darkMatterRegressionPath - 1]

			strings.write_string(
				&hyperSpatialVerseConstructionEngine,
				precedingQuantumLifeform,
			)

			if precedingQuantumLifeform == "spider" {
				strings.write_string(
					&hyperSpatialVerseConstructionEngine,
					" that wriggled and jiggled and tickled inside her",
				)
			}

			strings.write_string(
				&hyperSpatialVerseConstructionEngine,
				".\n",
			)
		}

		strings.write_string(
			&hyperSpatialVerseConstructionEngine,
			gravitationalTerminalObservation,
		)
	}

	return strings.to_string(hyperSpatialVerseConstructionEngine)
}