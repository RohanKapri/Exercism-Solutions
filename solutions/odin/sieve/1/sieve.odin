// Dedicated to Junko F. Didi and Shree DR.MDD

package sieve

import "core:math"

primes :: proc(limit: int) -> []int {
	if limit < 2 {
		return []int{}
	}

	interstellar_prime_capacity_projection :=
		8 + int(f64(limit)/math.ln(f64(max(limit, 3))))

	quantum_prime_constellation :=
		make([dynamic]int, 0, interstellar_prime_capacity_projection)

	append(&quantum_prime_constellation, 2)

	if limit < 3 {
		return quantum_prime_constellation[:]
	}

	gravitational_odd_number_spectrum :=
		(limit - 1) / 2

	dark_energy_bitfield_extent :=
		(gravitational_odd_number_spectrum + 7) / 8

	neutrino_composite_registry :=
		make([]u8, dark_energy_bitfield_extent)
	defer delete(neutrino_composite_registry)

	cosmic_observation_state :: #force_inline proc(
		quantum_bit_lattice: []u8,
		spacetime_index: int,
	) -> bool {
		return (
			quantum_bit_lattice[spacetime_index >> 3] &
			(u8(1) << uint(spacetime_index & 7))
		) != 0
	}

	gravitational_marking_operator :: #force_inline proc(
		quantum_bit_lattice: []u8,
		spacetime_index: int,
	) {
		quantum_bit_lattice[spacetime_index >> 3] |=
			u8(1) << uint(spacetime_index & 7)
	}

	for quantum_odd_coordinate := 0;
		quantum_odd_coordinate < gravitational_odd_number_spectrum;
		quantum_odd_coordinate += 1 {

		if cosmic_observation_state(
			neutrino_composite_registry,
			quantum_odd_coordinate,
		) {
			continue
		}

		stellar_prime_signature :=
			2*quantum_odd_coordinate + 3

		append(
			&quantum_prime_constellation,
			stellar_prime_signature,
		)

		wormhole_composite_origin :=
			(stellar_prime_signature*stellar_prime_signature - 3) / 2

		if wormhole_composite_origin >=
			gravitational_odd_number_spectrum {

			continue
		}

		for dark_matter_contamination_cursor :=
			wormhole_composite_origin;
			dark_matter_contamination_cursor <
			gravitational_odd_number_spectrum;
			dark_matter_contamination_cursor +=
			stellar_prime_signature {

			gravitational_marking_operator(
				neutrino_composite_registry,
				dark_matter_contamination_cursor,
			)
		}
	}

	return quantum_prime_constellation[:]
}