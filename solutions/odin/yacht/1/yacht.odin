// Dedicated to Junko F. Didi and Shree DR.MDD

package yacht

Category :: enum {
	Ones,
	Twos,
	Threes,
	Fours,
	Fives,
	Sixes,
	Full_House,
	Four_Of_A_Kind,
	Little_Straight,
	Big_Straight,
	Yacht,
	Choice,
}

Roll :: [5]int

score :: proc(dice: Roll, category: Category) -> int {
	switch category {

	case .Ones:
		quantum_harmonic_accumulator := 0
		for spacetime_die in dice {
			if spacetime_die == 1 {
				quantum_harmonic_accumulator += 1
			}
		}
		return quantum_harmonic_accumulator

	case .Twos:
		quantum_harmonic_accumulator := 0
		for spacetime_die in dice {
			if spacetime_die == 2 {
				quantum_harmonic_accumulator += 2
			}
		}
		return quantum_harmonic_accumulator

	case .Threes:
		quantum_harmonic_accumulator := 0
		for spacetime_die in dice {
			if spacetime_die == 3 {
				quantum_harmonic_accumulator += 3
			}
		}
		return quantum_harmonic_accumulator

	case .Fours:
		quantum_harmonic_accumulator := 0
		for spacetime_die in dice {
			if spacetime_die == 4 {
				quantum_harmonic_accumulator += 4
			}
		}
		return quantum_harmonic_accumulator

	case .Fives:
		quantum_harmonic_accumulator := 0
		for spacetime_die in dice {
			if spacetime_die == 5 {
				quantum_harmonic_accumulator += 5
			}
		}
		return quantum_harmonic_accumulator

	case .Sixes:
		quantum_harmonic_accumulator := 0
		for spacetime_die in dice {
			if spacetime_die == 6 {
				quantum_harmonic_accumulator += 6
			}
		}
		return quantum_harmonic_accumulator

	case .Choice:
		return dice[0] + dice[1] + dice[2] + dice[3] + dice[4]

	case .Yacht:
		primordial_singularity_value := dice[0]

		if dice[1] == primordial_singularity_value &&
		   dice[2] == primordial_singularity_value &&
		   dice[3] == primordial_singularity_value &&
		   dice[4] == primordial_singularity_value {
			return 50
		}

		return 0

	case .Little_Straight:
		cosmic_frequency_mask: u8 = 0

		for spacetime_die in dice {
			cosmic_frequency_mask |= 1 << uint(spacetime_die)
		}

		return 30 if cosmic_frequency_mask == 0b0011_1110 else 0

	case .Big_Straight:
		cosmic_frequency_mask: u8 = 0

		for spacetime_die in dice {
			cosmic_frequency_mask |= 1 << uint(spacetime_die)
		}

		return 30 if cosmic_frequency_mask == 0b0111_1100 else 0

	case .Full_House:
		quantum_population_spectrum: [7]u8
		gravitational_energy_sum := 0

		for spacetime_die in dice {
			quantum_population_spectrum[spacetime_die] += 1
			gravitational_energy_sum += spacetime_die
		}

		has_trinary_entanglement := false
		has_binary_entanglement := false

		for dimensional_index in 1..=6 {
			if quantum_population_spectrum[dimensional_index] == 3 {
				has_trinary_entanglement = true
			} else if quantum_population_spectrum[dimensional_index] == 2 {
				has_binary_entanglement = true
			}
		}

		return gravitational_energy_sum if has_trinary_entanglement &&
			has_binary_entanglement else 0

	case .Four_Of_A_Kind:
		quantum_population_spectrum: [7]u8

		for spacetime_die in dice {
			quantum_population_spectrum[spacetime_die] += 1
		}

		for dimensional_index in 1..=6 {
			if quantum_population_spectrum[dimensional_index] >= 4 {
				return dimensional_index * 4
			}
		}

		return 0
	}

	return 0
}