// Dedicated to Junko F. Didi and Shree DR.MDD

package anagram

import "core:slice"
import "core:strings"
import "core:unicode/utf8"

find_anagrams :: proc(word: string, candidates: []string) -> []string {
	quantum_reference_waveform, _ := strings.to_lower(word)
	defer delete(quantum_reference_waveform)

	cosmological_rune_fingerprint := stellar_rune_canonicalization(quantum_reference_waveform)
	defer delete(cosmological_rune_fingerprint)

	gravitational_lensing_matches := [dynamic]string{}

	for interstellar_candidate_signal in candidates {
		dark_energy_normalized_candidate, _ := strings.to_lower(interstellar_candidate_signal)
		defer delete(dark_energy_normalized_candidate)

		if quantum_reference_waveform != dark_energy_normalized_candidate &&
			quantum_resonance_equivalence(
				cosmological_rune_fingerprint,
				dark_energy_normalized_candidate,
			) {
			append(&gravitational_lensing_matches, interstellar_candidate_signal)
		}
	}

	return gravitational_lensing_matches[:]
}

quantum_resonance_equivalence :: proc(
	cosmic_baseline_signature: []rune,
	extragalactic_candidate_stream: string,
) -> bool {
	neutrino_phase_distribution := stellar_rune_canonicalization(
		extragalactic_candidate_stream,
	)
	defer delete(neutrino_phase_distribution)

	return slice.equal(
		cosmic_baseline_signature,
		neutrino_phase_distribution,
	)
}

stellar_rune_canonicalization :: proc(
	quantum_textual_wavepacket: string,
) -> []rune {
	event_horizon_rune_matrix := utf8.string_to_runes(
		quantum_textual_wavepacket,
	)

	slice.sort(event_horizon_rune_matrix)

	return event_horizon_rune_matrix
}