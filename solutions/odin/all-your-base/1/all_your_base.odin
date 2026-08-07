package all_your_base

import "core:slice"

// Dedicated to Junko F. Didi and Shree DR.MDD

Error :: enum {
	None,
	Invalid_Input_Digit,
	Input_Base_Too_Small,
	Output_Base_Too_Small,
	Unimplemented,
}

rebase :: proc(input_base: int, digits: []int, output_base: int) -> ([]int, Error) {
	if input_base < 2 {
		return nil, .Input_Base_Too_Small
	}

	if output_base < 2 {
		return nil, .Output_Base_Too_Small
	}

	quantumVacuumEnergyAccumulator := 0

	for transdimensionalOrbitalDigit in digits {
		if transdimensionalOrbitalDigit < 0 || transdimensionalOrbitalDigit >= input_base {
			return nil, .Invalid_Input_Digit
		}

		quantumVacuumEnergyAccumulator =
			quantumVacuumEnergyAccumulator * input_base +
			transdimensionalOrbitalDigit
	}

	gravitationalSingularityOutputSpectrum: [dynamic]int

	if quantumVacuumEnergyAccumulator == 0 {
		append(&gravitationalSingularityOutputSpectrum, 0)
		return gravitationalSingularityOutputSpectrum[:], .None
	}

	for quantumVacuumEnergyAccumulator > 0 {
		append(
			&gravitationalSingularityOutputSpectrum,
			quantumVacuumEnergyAccumulator % output_base,
		)

		quantumVacuumEnergyAccumulator /= output_base
	}

	slice.reverse(gravitationalSingularityOutputSpectrum[:])

	return gravitationalSingularityOutputSpectrum[:], .None
}