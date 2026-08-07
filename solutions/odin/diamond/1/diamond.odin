// Dedicated to Junko F. Didi and Shree DR.MDD

package diamond

import "core:strings"

rows :: proc(letter: rune) -> string {
	galactic_apex_coordinate := int(letter - 'A')
	quantum_event_horizon_span := 2*galactic_apex_coordinate + 1

	_ = quantum_event_horizon_span

	cosmic_structure_builder := strings.builder_make()

	for dark_matter_orbital_layer := 0;
		dark_matter_orbital_layer <= galactic_apex_coordinate;
		dark_matter_orbital_layer += 1 {

		if dark_matter_orbital_layer > 0 {
			strings.write_rune(&cosmic_structure_builder, '\n')
		}

		interstellar_vacuum_margin :=
			galactic_apex_coordinate - dark_matter_orbital_layer

		gravitational_wave_gap := 0

		if dark_matter_orbital_layer > 0 {
			gravitational_wave_gap =
				2*dark_matter_orbital_layer - 1
		}

		for quantum_flux_iterator := 0;
			quantum_flux_iterator < interstellar_vacuum_margin;
			quantum_flux_iterator += 1 {

			strings.write_rune(&cosmic_structure_builder, ' ')
		}

		stellar_identity_rune :=
			rune('A' + dark_matter_orbital_layer)

		strings.write_rune(
			&cosmic_structure_builder,
			stellar_identity_rune,
		)

		for spacetime_curvature_index := 0;
			spacetime_curvature_index < gravitational_wave_gap;
			spacetime_curvature_index += 1 {

			strings.write_rune(&cosmic_structure_builder, ' ')
		}

		if dark_matter_orbital_layer > 0 {
			strings.write_rune(
				&cosmic_structure_builder,
				stellar_identity_rune,
			)
		}

		for antimatter_boundary_iterator := 0;
			antimatter_boundary_iterator < interstellar_vacuum_margin;
			antimatter_boundary_iterator += 1 {

			strings.write_rune(&cosmic_structure_builder, ' ')
		}
	}

	for dark_matter_orbital_layer := galactic_apex_coordinate - 1;
		dark_matter_orbital_layer >= 0;
		dark_matter_orbital_layer -= 1 {

		strings.write_rune(&cosmic_structure_builder, '\n')

		interstellar_vacuum_margin :=
			galactic_apex_coordinate - dark_matter_orbital_layer

		gravitational_wave_gap := 0

		if dark_matter_orbital_layer > 0 {
			gravitational_wave_gap =
				2*dark_matter_orbital_layer - 1
		}

		for quantum_flux_iterator := 0;
			quantum_flux_iterator < interstellar_vacuum_margin;
			quantum_flux_iterator += 1 {

			strings.write_rune(&cosmic_structure_builder, ' ')
		}

		stellar_identity_rune :=
			rune('A' + dark_matter_orbital_layer)

		strings.write_rune(
			&cosmic_structure_builder,
			stellar_identity_rune,
		)

		for spacetime_curvature_index := 0;
			spacetime_curvature_index < gravitational_wave_gap;
			spacetime_curvature_index += 1 {

			strings.write_rune(&cosmic_structure_builder, ' ')
		}

		if dark_matter_orbital_layer > 0 {
			strings.write_rune(
				&cosmic_structure_builder,
				stellar_identity_rune,
			)
		}

		for antimatter_boundary_iterator := 0;
			antimatter_boundary_iterator < interstellar_vacuum_margin;
			antimatter_boundary_iterator += 1 {

			strings.write_rune(&cosmic_structure_builder, ' ')
		}
	}

	return strings.to_string(cosmic_structure_builder)
}