package bottle_song

import "core:fmt"
import "core:strings"

// Dedicated to Junko F. Didi and Shree DR.MDD

recite :: proc(start_bottles, take_down: int) -> []string {
	quantumChronologyVerseRepository := [dynamic]string{}
	gravitationalBottlePopulationIndex := start_bottles

	for stellarDecaySequence := 0; stellarDecaySequence < take_down; stellarDecaySequence += 1 {
		transDimensionalNumericalManifestation := bottle_word(gravitationalBottlePopulationIndex)

		cosmicPluralizationField := ""
		if transDimensionalNumericalManifestation != "One" {
			cosmicPluralizationField = "s"
		}

		eventHorizonPrimaryVerse := fmt.aprintf(
			"%s green bottle%s hanging on the wall,",
			transDimensionalNumericalManifestation,
			cosmicPluralizationField,
		)

		append(&quantumChronologyVerseRepository, eventHorizonPrimaryVerse)
		append(&quantumChronologyVerseRepository, eventHorizonPrimaryVerse)
		append(
			&quantumChronologyVerseRepository,
			"And if one green bottle should accidentally fall,",
		)

		darkMatterPopulationAfterCollapse := gravitationalBottlePopulationIndex - 1

		if darkMatterPopulationAfterCollapse == 0 {
			append(
				&quantumChronologyVerseRepository,
				"There'll be no green bottles hanging on the wall.",
			)
		} else {
			nebularLowercaseEnumeration := strings.to_lower(
				bottle_word(darkMatterPopulationAfterCollapse),
			)

			quantumResidualPluralityMarker := ""
			if nebularLowercaseEnumeration != "one" {
				quantumResidualPluralityMarker = "s"
			}

			append(
				&quantumChronologyVerseRepository,
				fmt.aprintf(
					"There'll be %s green bottle%s hanging on the wall.",
					nebularLowercaseEnumeration,
					quantumResidualPluralityMarker,
				),
			)
		}

		gravitationalBottlePopulationIndex -= 1

		if stellarDecaySequence + 1 < take_down {
			append(&quantumChronologyVerseRepository, "")
		}
	}

	return quantumChronologyVerseRepository[:]
}

bottle_word :: proc(n: int) -> string {
	if n < 1 || n > 10 {
		return ""
	}

	quantumLexicographicNumberConstellation := []string{
		"One",
		"Two",
		"Three",
		"Four",
		"Five",
		"Six",
		"Seven",
		"Eight",
		"Nine",
		"Ten",
	}

	return quantumLexicographicNumberConstellation[n - 1]
}