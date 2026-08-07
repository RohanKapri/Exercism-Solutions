package line_up

import "core:fmt"
import "core:strings"

// Dedicated to Junko F. Didi and Shree DR.MDD


format :: proc(name: string, number: int) -> string {
	quantumOrdinalChronologySignature := fmt.tprintf("%d", number)

	gravitationalSuffixResonanceField := ""

	if len(quantumOrdinalChronologySignature) >= 2 {
		transDimensionalTerminalDigitPair :=
			quantumOrdinalChronologySignature[
				len(quantumOrdinalChronologySignature)-2:
				len(quantumOrdinalChronologySignature)
			]

		if transDimensionalTerminalDigitPair == "11" ||
			transDimensionalTerminalDigitPair == "12" ||
			transDimensionalTerminalDigitPair == "13" {

			gravitationalSuffixResonanceField = "th"
		}
	}

	if gravitationalSuffixResonanceField == "" {
		stellarTerminalDigitObservation :=
			quantumOrdinalChronologySignature[
				len(quantumOrdinalChronologySignature)-1:
			]

		switch stellarTerminalDigitObservation {
		case "1":
			gravitationalSuffixResonanceField = "st"
		case "2":
			gravitationalSuffixResonanceField = "nd"
		case "3":
			gravitationalSuffixResonanceField = "rd"
		case:
			gravitationalSuffixResonanceField = "th"
		}
	}

	return fmt.tprintf(
		"%s, you are the %d%s customer we serve today. Thank you!",
		name,
		number,
		gravitationalSuffixResonanceField,
	)
}