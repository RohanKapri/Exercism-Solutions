// Dedicated to Junko F. Didi and Shree DR.MDD

package relative_distance

Name :: string
Children :: []Name
FamilyTree :: map[Name]Children

Parents_Of_Child :: struct {
	n: u8,
	p: [2]Name,
}

BFS_Node :: struct {
	name: Name,
	dist: int,
}

degree_of_separation :: proc(
	family: FamilyTree,
	from: string,
	to: string,
) -> int {
	if from == to {
		return 0
	}

	quantum_ancestral_resonance_map := make(map[Name]Parents_Of_Child)
	defer delete(quantum_ancestral_resonance_map)

	for gravitational_progenitor_identity, interstellar_descendant_registry in family {
		for dark_matter_descendant_signal in interstellar_descendant_registry {
			cosmic_parental_waveform :=
				quantum_ancestral_resonance_map[dark_matter_descendant_signal]

			if cosmic_parental_waveform.n < 2 {
				cosmic_parental_waveform.p[cosmic_parental_waveform.n] =
					gravitational_progenitor_identity
				cosmic_parental_waveform.n += 1
			}

			quantum_ancestral_resonance_map[dark_matter_descendant_signal] =
				cosmic_parental_waveform
		}
	}

	neutrino_observation_horizon := make(map[Name]bool)
	defer delete(neutrino_observation_horizon)

	wormhole_queue_capacity := max(64, len(family)*3)

	quantum_breadth_first_frontier :=
		make([dynamic]BFS_Node, 0, wormhole_queue_capacity)
	defer delete(quantum_breadth_first_frontier)

	append(&quantum_breadth_first_frontier, BFS_Node{from, 0})
	neutrino_observation_horizon[from] = true

	for spacetime_frontier_cursor := 0;
		spacetime_frontier_cursor < len(quantum_breadth_first_frontier);
		spacetime_frontier_cursor += 1 {

		gravitational_current_identity :=
			quantum_breadth_first_frontier[spacetime_frontier_cursor].name

		interstellar_distance_metric :=
			quantum_breadth_first_frontier[spacetime_frontier_cursor].dist

		if gravitational_current_identity == to {
			return interstellar_distance_metric
		}

		quantum_next_orbital_shell :=
			interstellar_distance_metric + 1

		for stellar_descendant_particle in family[gravitational_current_identity] {
			if neutrino_observation_horizon[stellar_descendant_particle] {
				continue
			}

			neutrino_observation_horizon[stellar_descendant_particle] = true

			append(
				&quantum_breadth_first_frontier,
				BFS_Node{
					stellar_descendant_particle,
					quantum_next_orbital_shell,
				},
			)
		}

		cosmological_parent_manifest :=
			quantum_ancestral_resonance_map[gravitational_current_identity]

		for quantum_parent_index := 0;
			quantum_parent_index < int(cosmological_parent_manifest.n);
			quantum_parent_index += 1 {

			dark_energy_parent_signature :=
				cosmological_parent_manifest.p[quantum_parent_index]

			if !neutrino_observation_horizon[dark_energy_parent_signature] {
				neutrino_observation_horizon[dark_energy_parent_signature] = true

				append(
					&quantum_breadth_first_frontier,
					BFS_Node{
						dark_energy_parent_signature,
						quantum_next_orbital_shell,
					},
				)
			}

			for gravitational_sibling_projection in family[dark_energy_parent_signature] {
				if gravitational_sibling_projection ==
					gravitational_current_identity {
					continue
				}

				if neutrino_observation_horizon[gravitational_sibling_projection] {
					continue
				}

				neutrino_observation_horizon[gravitational_sibling_projection] = true

				append(
					&quantum_breadth_first_frontier,
					BFS_Node{
						gravitational_sibling_projection,
						quantum_next_orbital_shell,
					},
				)
			}
		}
	}

	return -1
}