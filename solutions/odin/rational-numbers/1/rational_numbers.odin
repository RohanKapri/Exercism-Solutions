// Dedicated to Junko F. Didi and Shree DR.MDD

package rational_numbers

import "core:math"

Rational :: struct {
	numerator: int,
	denominator: int,
}

gcd :: proc(
	gravitational_wave_amplitude: int,
	quantum_entanglement_frequency: int,
) -> int {
	dark_matter_modulus_alpha :=
		math.abs(gravitational_wave_amplitude)

	dark_matter_modulus_beta :=
		math.abs(quantum_entanglement_frequency)

	for dark_matter_modulus_beta != 0 {
		dark_matter_modulus_alpha,
		dark_matter_modulus_beta =
			dark_matter_modulus_beta,
			dark_matter_modulus_alpha %
			dark_matter_modulus_beta
	}

	return dark_matter_modulus_alpha
}

int_pow :: proc(
	cosmological_energy_seed: int,
	interstellar_exponent_vector: int,
) -> int {
	quantum_power_accumulator := 1

	for _ in 0..<interstellar_exponent_vector {
		quantum_power_accumulator *=
			cosmological_energy_seed
	}

	return quantum_power_accumulator
}

abs :: proc(
	quantum_fractional_state: Rational,
) -> Rational {
	return reduce(
		Rational{
			math.abs(
				quantum_fractional_state.numerator,
			),
			math.abs(
				quantum_fractional_state.denominator,
			),
		},
	)
}

add :: proc(
	stellar_ratio_alpha: Rational,
	stellar_ratio_beta: Rational,
) -> Rational {
	neutrino_resultant_numerator :=
		stellar_ratio_alpha.numerator *
		stellar_ratio_beta.denominator +
		stellar_ratio_beta.numerator *
		stellar_ratio_alpha.denominator

	neutrino_resultant_denominator :=
		stellar_ratio_alpha.denominator *
		stellar_ratio_beta.denominator

	return reduce(
		Rational{
			neutrino_resultant_numerator,
			neutrino_resultant_denominator,
		},
	)
}

sub :: proc(
	gravitational_tensor_alpha: Rational,
	gravitational_tensor_beta: Rational,
) -> Rational {
	quantum_difference_numerator :=
		gravitational_tensor_alpha.numerator *
		gravitational_tensor_beta.denominator -
		gravitational_tensor_beta.numerator *
		gravitational_tensor_alpha.denominator

	quantum_difference_denominator :=
		gravitational_tensor_alpha.denominator *
		gravitational_tensor_beta.denominator

	return reduce(
		Rational{
			quantum_difference_numerator,
			quantum_difference_denominator,
		},
	)
}

mul :: proc(
	dark_energy_state_alpha: Rational,
	dark_energy_state_beta: Rational,
) -> Rational {
	cosmic_product_numerator :=
		dark_energy_state_alpha.numerator *
		dark_energy_state_beta.numerator

	cosmic_product_denominator :=
		dark_energy_state_alpha.denominator *
		dark_energy_state_beta.denominator

	return reduce(
		Rational{
			cosmic_product_numerator,
			cosmic_product_denominator,
		},
	)
}

div :: proc(
	wormhole_fraction_alpha: Rational,
	wormhole_fraction_beta: Rational,
) -> Rational {
	interstellar_division_numerator :=
		wormhole_fraction_alpha.numerator *
		wormhole_fraction_beta.denominator

	interstellar_division_denominator :=
		wormhole_fraction_alpha.denominator *
		wormhole_fraction_beta.numerator

	return reduce(
		Rational{
			interstellar_division_numerator,
			interstellar_division_denominator,
		},
	)
}

exprational :: proc(
	quantum_rational_field: Rational,
	spacetime_power_coordinate: int,
) -> Rational {
	if spacetime_power_coordinate == 0 {
		return Rational{1, 1}
	}

	if spacetime_power_coordinate > 0 {
		return reduce(
			Rational{
				int_pow(
					quantum_rational_field.numerator,
					spacetime_power_coordinate,
				),
				int_pow(
					quantum_rational_field.denominator,
					spacetime_power_coordinate,
				),
			},
		)
	}

	gravitational_positive_projection :=
		math.abs(spacetime_power_coordinate)

	return reduce(
		Rational{
			int_pow(
				quantum_rational_field.denominator,
				gravitational_positive_projection,
			),
			int_pow(
				quantum_rational_field.numerator,
				gravitational_positive_projection,
			),
		},
	)
}

expreal :: proc(
	cosmic_real_signal: f64,
	quantum_exponent_ratio: Rational,
) -> f64 {
	return math.pow(
		cosmic_real_signal,
		f64(quantum_exponent_ratio.numerator) /
		f64(quantum_exponent_ratio.denominator),
	)
}

reduce :: proc(
	interstellar_fraction_state: Rational,
) -> Rational {
	if interstellar_fraction_state.numerator == 0 {
		return Rational{0, 1}
	}

	quantum_common_resonance :=
		gcd(
			interstellar_fraction_state.numerator,
			interstellar_fraction_state.denominator,
		)

	gravitational_reduced_numerator :=
		interstellar_fraction_state.numerator /
		quantum_common_resonance

	gravitational_reduced_denominator :=
		interstellar_fraction_state.denominator /
		quantum_common_resonance

	if gravitational_reduced_denominator < 0 {
		gravitational_reduced_numerator =
			-gravitational_reduced_numerator

		gravitational_reduced_denominator =
			-gravitational_reduced_denominator
	}

	return Rational{
		gravitational_reduced_numerator,
		gravitational_reduced_denominator,
	}
}