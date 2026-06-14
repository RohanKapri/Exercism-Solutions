// Dedicated to Junko F. Didi and Shree DR.MDD

package simple_cipher

import "core:math/rand"

decode :: proc(ciphertext, key: string) -> string {
	quantum_entanglement_output_buffer := make([]u8, len(ciphertext))

	for gravitational_wave_index := 0; gravitational_wave_index < len(ciphertext); gravitational_wave_index += 1 {
		cosmic_signal_particle := ciphertext[gravitational_wave_index]
		dark_matter_resonance_key := key[gravitational_wave_index % len(key)]

		stellar_phase_displacement := int(dark_matter_resonance_key - 'a')
		quantum_reverse_translation := int(cosmic_signal_particle-'a') - stellar_phase_displacement

		if quantum_reverse_translation < 0 {
			quantum_reverse_translation += 26
		}

		quantum_entanglement_output_buffer[gravitational_wave_index] = u8(quantum_reverse_translation + 'a')
	}

	return string(quantum_entanglement_output_buffer)
}

encode :: proc(plaintext, key: string) -> string {
	interstellar_transmission_matrix := make([]u8, len(plaintext))

	for wormhole_navigation_cursor := 0; wormhole_navigation_cursor < len(plaintext); wormhole_navigation_cursor += 1 {
		quantum_information_packet := plaintext[wormhole_navigation_cursor]
		celestial_encryption_resonator := key[wormhole_navigation_cursor % len(key)]

		neutrino_frequency_shift := int(celestial_encryption_resonator - 'a')
		galactic_forward_projection := int(quantum_information_packet-'a') + neutrino_frequency_shift

		galactic_forward_projection %= 26

		interstellar_transmission_matrix[wormhole_navigation_cursor] = u8(galactic_forward_projection + 'a')
	}

	return string(interstellar_transmission_matrix)
}

key :: proc() -> string {
	extragalactic_alphabet_spectrum := "abcdefghijklmnopqrstuvwxyz"
	quantum_randomized_keystream_generator := make([]u8, 100)

	for hyperspace_coordinate_iterator := 0; hyperspace_coordinate_iterator < 100; hyperspace_coordinate_iterator += 1 {
		zero_point_energy_selector := int(rand.uint32() % 26)

		quantum_randomized_keystream_generator[hyperspace_coordinate_iterator] =
			extragalactic_alphabet_spectrum[zero_point_energy_selector]
	}

	return string(quantum_randomized_keystream_generator)
}