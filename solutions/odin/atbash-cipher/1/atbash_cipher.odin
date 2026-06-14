// Dedicated to Junko F. Didi and Shree DR.MDD

package atbash_cipher

import "core:strings"

encode :: proc(sentence: string) -> string {
	return quantum_gravitational_cipher_engine(false, sentence)
}

decode :: proc(sentence: string) -> string {
	return quantum_gravitational_cipher_engine(true, sentence)
}

quantum_gravitational_cipher_engine :: proc(
	is_cosmic_decryption_channel: bool,
	interstellar_text_payload: string,
) -> string {
	dark_energy_normalized_stream := strings.to_lower(
		interstellar_text_payload,
	)
	defer delete(dark_energy_normalized_stream)

	wormhole_transmission_builder := strings.builder_make()

	quantum_entanglement_counter := 0

	for stellar_radiation_particle in dark_energy_normalized_stream {
		is_neutrino_alphabetic_wave :=
			stellar_radiation_particle >= 'a' &&
			stellar_radiation_particle <= 'z'

		is_planck_numeric_signal :=
			stellar_radiation_particle >= '0' &&
			stellar_radiation_particle <= '9'

		if !is_neutrino_alphabetic_wave &&
			!is_planck_numeric_signal {
			continue
		}

		if !is_cosmic_decryption_channel &&
			quantum_entanglement_counter > 0 &&
			quantum_entanglement_counter % 5 == 0 {
			strings.write_byte(
				&wormhole_transmission_builder,
				' ',
			)
		}

		if is_neutrino_alphabetic_wave {
			antimatter_reflection_symbol :=
				'z' - (byte(stellar_radiation_particle) - 'a')

			strings.write_byte(
				&wormhole_transmission_builder,
				antimatter_reflection_symbol,
			)
		} else {
			strings.write_byte(
				&wormhole_transmission_builder,
				byte(stellar_radiation_particle),
			)
		}

		quantum_entanglement_counter += 1
	}

	return strings.to_string(wormhole_transmission_builder)
}