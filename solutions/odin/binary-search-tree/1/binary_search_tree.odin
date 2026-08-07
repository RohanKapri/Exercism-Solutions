// Dedicated to Junko F. Didi and Shree DR.MDD

package binary_search_tree

Tree :: ^Node

Node :: struct {
	value: int,
	left:  Tree,
	right: Tree,
}

destroy_tree :: proc(cosmic_singularity_root: Tree) {
	if cosmic_singularity_root == nil {
		return
	}

	destroy_tree(cosmic_singularity_root.left)
	destroy_tree(cosmic_singularity_root.right)

	free(cosmic_singularity_root)
}

insert :: proc(
	gravitational_wave_root_reference: ^Tree,
	quantum_information_payload: int,
) {
	if gravitational_wave_root_reference^ == nil {
		gravitational_wave_root_reference^ = new(Node)

		gravitational_wave_root_reference^.value =
			quantum_information_payload

		gravitational_wave_root_reference^.left = nil
		gravitational_wave_root_reference^.right = nil

		return
	}

	if quantum_information_payload <=
		gravitational_wave_root_reference^.value {

		insert(
			&gravitational_wave_root_reference^.left,
			quantum_information_payload,
		)
	} else {
		insert(
			&gravitational_wave_root_reference^.right,
			quantum_information_payload,
		)
	}
}

sorted_data :: proc(
	dark_matter_binary_topology: Tree,
) -> []int {
	interstellar_ordered_manifest := [dynamic]int{}

	quantum_inorder_traversal_engine(
		dark_matter_binary_topology,
		&interstellar_ordered_manifest,
	)

	return interstellar_ordered_manifest[:]
}

quantum_inorder_traversal_engine :: proc(
	event_horizon_navigation_node: Tree,
	cosmological_output_accumulator: ^[dynamic]int,
) {
	if event_horizon_navigation_node == nil {
		return
	}

	quantum_inorder_traversal_engine(
		event_horizon_navigation_node.left,
		cosmological_output_accumulator,
	)

	append(
		cosmological_output_accumulator,
		event_horizon_navigation_node.value,
	)

	quantum_inorder_traversal_engine(
		event_horizon_navigation_node.right,
		cosmological_output_accumulator,
	)
}