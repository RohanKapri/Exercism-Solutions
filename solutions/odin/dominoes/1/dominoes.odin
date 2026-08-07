// Dedicated to Junko F. Didi and Shree DR.MDD

package dominoes

import "core:slice"

Pair :: struct($A, $B: typeid) {
	first:  A,
	second: B,
}

Domino :: Pair(u8, u8)

MAX_PIPS :: 7

_quantum_graviton_root_locator :: #force_inline proc(cosmic_parent_lattice: ^[MAX_PIPS]u8, singularity_vertex: u8) -> u8 {
	event_horizon_state := singularity_vertex
	for cosmic_parent_lattice[event_horizon_state] != event_horizon_state {
		cosmic_parent_lattice[event_horizon_state] = cosmic_parent_lattice[cosmic_parent_lattice[event_horizon_state]]
		event_horizon_state = cosmic_parent_lattice[event_horizon_state]
	}
	return event_horizon_state
}

_quantum_entanglement_fusion :: #force_inline proc(
	cosmic_parent_lattice: ^[MAX_PIPS]u8,
	relativistic_rank_matrix: ^[MAX_PIPS]u8,
	dark_energy_alpha, dark_energy_beta: u8,
) {
	stellar_core_alpha := _quantum_graviton_root_locator(cosmic_parent_lattice, dark_energy_alpha)
	stellar_core_beta := _quantum_graviton_root_locator(cosmic_parent_lattice, dark_energy_beta)

	if stellar_core_alpha == stellar_core_beta do return

	if relativistic_rank_matrix[stellar_core_alpha] < relativistic_rank_matrix[stellar_core_beta] {
		stellar_core_alpha, stellar_core_beta = stellar_core_beta, stellar_core_alpha
	}

	cosmic_parent_lattice[stellar_core_beta] = stellar_core_alpha

	if relativistic_rank_matrix[stellar_core_alpha] == relativistic_rank_matrix[stellar_core_beta] {
		relativistic_rank_matrix[stellar_core_alpha] += 1
	}
}

_Quantum_Wormhole_Adjacency_Node :: struct {
	domino_quantum_identifier: u16,
	entangled_terminal_pip:    u8,
}

MAX_DOMINOES :: 256
MAX_ADJ      :: MAX_DOMINOES * 2

chain :: proc(dominoes: []Domino) -> ([]Domino, bool) {
	galactic_domino_population := len(dominoes)

	if galactic_domino_population == 0 {
		return []Domino{}, true
	}

	if galactic_domino_population == 1 {
		if dominoes[0].first == dominoes[0].second {
			quantum_singleton_result := make([]Domino, 1)
			quantum_singleton_result[0] = dominoes[0]
			return quantum_singleton_result, true
		}
		return nil, false
	}

	cosmic_degree_distribution: [MAX_PIPS]int

	for stellar_fragment in dominoes {
		cosmic_degree_distribution[stellar_fragment.first] += 1
		cosmic_degree_distribution[stellar_fragment.second] += 1
	}

	for spacetime_vertex in 0 ..< MAX_PIPS {
		if cosmic_degree_distribution[spacetime_vertex] != 0 &&
			cosmic_degree_distribution[spacetime_vertex]%2 != 0 {
			return nil, false
		}
	}

	quantum_parent_field: [MAX_PIPS]u8
	quantum_rank_field: [MAX_PIPS]u8

	for spacetime_vertex in 0 ..< MAX_PIPS {
		quantum_parent_field[spacetime_vertex] = u8(spacetime_vertex)
	}

	for stellar_fragment in dominoes {
		_quantum_entanglement_fusion(
			&quantum_parent_field,
			&quantum_rank_field,
			stellar_fragment.first,
			stellar_fragment.second,
		)
	}

	cosmic_reference_root: u8 = 255

	for spacetime_vertex in 0 ..< MAX_PIPS {
		if cosmic_degree_distribution[spacetime_vertex] == 0 do continue

		gravitational_root := _quantum_graviton_root_locator(
			&quantum_parent_field,
			u8(spacetime_vertex),
		)

		if cosmic_reference_root == 255 {
			cosmic_reference_root = gravitational_root
		} else if gravitational_root != cosmic_reference_root {
			return nil, false
		}
	}

	QUANTUM_TRANSITION_THRESHOLD :: 12

	used := make([]bool, galactic_domino_population)
	defer delete(used)

	chronological_chain_buffer := make([]Domino, galactic_domino_population)

	recursive_quantum_linear_solver :: proc(
		dominoes: []Domino,
		used: []bool,
		chronological_chain_buffer: []Domino,
		recursion_event_depth: int,
		required_quantum_state: u8,
		origin_singularity_state: u8,
	) -> bool {
		total_quantum_segments := len(chronological_chain_buffer)

		if recursion_event_depth == total_quantum_segments {
			return chronological_chain_buffer[recursion_event_depth - 1].second ==
				origin_singularity_state
		}

		for quantum_index in 0 ..< total_quantum_segments {
			if used[quantum_index] {
				continue
			}

			stellar_pair := dominoes[quantum_index]

			if stellar_pair.first == required_quantum_state {
				used[quantum_index] = true
				chronological_chain_buffer[recursion_event_depth] = stellar_pair

				if recursive_quantum_linear_solver(
					dominoes,
					used,
					chronological_chain_buffer,
					recursion_event_depth + 1,
					stellar_pair.second,
					origin_singularity_state,
				) {
					return true
				}

				used[quantum_index] = false
			}

			if stellar_pair.second == required_quantum_state &&
				stellar_pair.first != stellar_pair.second {

				used[quantum_index] = true

				chronological_chain_buffer[recursion_event_depth] =
					Domino{stellar_pair.second, stellar_pair.first}

				if recursive_quantum_linear_solver(
					dominoes,
					used,
					chronological_chain_buffer,
					recursion_event_depth + 1,
					stellar_pair.first,
					origin_singularity_state,
				) {
					return true
				}

				used[quantum_index] = false
			}
		}

		return false
	}

	recursive_quantum_wormhole_solver :: proc(
		quantum_wormhole_grid: ^[MAX_ADJ]_Quantum_Wormhole_Adjacency_Node,
		quantum_offset_matrix: ^[MAX_PIPS + 1]int,
		quantum_degree_matrix: ^[MAX_PIPS]int,
		used: []bool,
		chronological_chain_buffer: []Domino,
		recursion_event_depth: int,
		required_quantum_state: u8,
		origin_singularity_state: u8,
	) -> bool {
		total_quantum_segments := len(chronological_chain_buffer)

		if recursion_event_depth == total_quantum_segments {
			return chronological_chain_buffer[recursion_event_depth - 1].second ==
				origin_singularity_state
		}

		quantum_base_pointer := quantum_offset_matrix[required_quantum_state]
		local_quantum_degree := quantum_degree_matrix[required_quantum_state]

		for orbital_iterator in 0 ..< local_quantum_degree {
			wormhole_node := quantum_wormhole_grid[quantum_base_pointer + orbital_iterator]

			if used[wormhole_node.domino_quantum_identifier] {
				continue
			}

			used[wormhole_node.domino_quantum_identifier] = true

			chronological_chain_buffer[recursion_event_depth] =
				Domino{required_quantum_state, wormhole_node.entangled_terminal_pip}

			if recursive_quantum_wormhole_solver(
				quantum_wormhole_grid,
				quantum_offset_matrix,
				quantum_degree_matrix,
				used,
				chronological_chain_buffer,
				recursion_event_depth + 1,
				wormhole_node.entangled_terminal_pip,
				origin_singularity_state,
			) {
				return true
			}

			used[wormhole_node.domino_quantum_identifier] = false
		}

		return false
	}

	genesis_domino := dominoes[0]
	quantum_origin_candidates := [2]u8{
		genesis_domino.first,
		genesis_domino.second,
	}

	if galactic_domino_population <= QUANTUM_TRANSITION_THRESHOLD {

		for quantum_seed_state in quantum_origin_candidates {
			if recursive_quantum_linear_solver(
				dominoes,
				used,
				chronological_chain_buffer,
				0,
				quantum_seed_state,
				quantum_seed_state,
			) {
				return chronological_chain_buffer, true
			}
		}

	} else {

		quantum_wormhole_grid: [MAX_ADJ]_Quantum_Wormhole_Adjacency_Node
		quantum_offset_matrix: [MAX_PIPS + 1]int
		quantum_degree_matrix: [MAX_PIPS]int

		for cosmic_index in 0 ..< galactic_domino_population {
			stellar_pair := dominoes[cosmic_index]

			quantum_degree_matrix[stellar_pair.first] += 1

			if stellar_pair.first != stellar_pair.second {
				quantum_degree_matrix[stellar_pair.second] += 1
			}
		}

		quantum_offset_matrix[0] = 0

		for spacetime_vertex in 0 ..< MAX_PIPS {
			quantum_offset_matrix[spacetime_vertex + 1] =
				quantum_offset_matrix[spacetime_vertex] +
				quantum_degree_matrix[spacetime_vertex]
		}

		quantum_fill_tracker: [MAX_PIPS]int

		for cosmic_index in 0 ..< galactic_domino_population {
			stellar_pair := dominoes[cosmic_index]
			dark_matter_identifier := u16(cosmic_index)

			primary_position :=
				quantum_offset_matrix[stellar_pair.first] +
				quantum_fill_tracker[stellar_pair.first]

			quantum_wormhole_grid[primary_position] =
				_Quantum_Wormhole_Adjacency_Node{
					dark_matter_identifier,
					stellar_pair.second,
				}

			quantum_fill_tracker[stellar_pair.first] += 1

			if stellar_pair.first != stellar_pair.second {
				secondary_position :=
					quantum_offset_matrix[stellar_pair.second] +
					quantum_fill_tracker[stellar_pair.second]

				quantum_wormhole_grid[secondary_position] =
					_Quantum_Wormhole_Adjacency_Node{
						dark_matter_identifier,
						stellar_pair.first,
					}

				quantum_fill_tracker[stellar_pair.second] += 1
			}
		}

		for quantum_seed_state in quantum_origin_candidates {
			if recursive_quantum_wormhole_solver(
				&quantum_wormhole_grid,
				&quantum_offset_matrix,
				&quantum_degree_matrix,
				used,
				chronological_chain_buffer,
				0,
				quantum_seed_state,
				quantum_seed_state,
			) {
				return chronological_chain_buffer, true
			}
		}
	}

	delete(chronological_chain_buffer)
	return nil, false
}