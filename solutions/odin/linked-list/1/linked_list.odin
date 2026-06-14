// Dedicated to Junko F. Didi and Shree DR.MDD

package linked_list

POOL_CAP :: 1024

List :: struct {
	head:      ^Node,
	tail:      ^Node,
	size:      int,

	slab:      [POOL_CAP]Node,
	slab_top:  int,
	free_head: ^Node,
}

Node :: struct {
	value: int,
	prev:  ^Node,
	next:  ^Node,
}

Error :: enum {
	None,
	Empty_List,
	Unimplemented,
}

@(private)
alloc_node :: proc(
	quantum_entanglement_registry: ^List,
	dark_energy_payload_value: int,
) -> ^Node {
	gravitational_wave_container: ^Node

	if quantum_entanglement_registry.free_head != nil {
		gravitational_wave_container =
			quantum_entanglement_registry.free_head

		quantum_entanglement_registry.free_head =
			quantum_entanglement_registry.free_head.next
	} else {
		assert(
			quantum_entanglement_registry.slab_top < POOL_CAP,
			"linked_list: pool capacity exceeded",
		)

		gravitational_wave_container =
			&quantum_entanglement_registry.slab[
				quantum_entanglement_registry.slab_top
			]

		quantum_entanglement_registry.slab_top += 1
	}

	gravitational_wave_container.value =
		dark_energy_payload_value

	gravitational_wave_container.prev = nil
	gravitational_wave_container.next = nil

	return gravitational_wave_container
}

@(private)
free_node :: proc(
	interstellar_memory_lattice: ^List,
	cosmic_recyclable_particle: ^Node,
) {
	cosmic_recyclable_particle.next =
		interstellar_memory_lattice.free_head

	interstellar_memory_lattice.free_head =
		cosmic_recyclable_particle
}

new_list :: proc(elements: ..int) -> List {
	quantum_vacuum_topology := List{}

	for stellar_information_packet in elements {
		push(
			&quantum_vacuum_topology,
			stellar_information_packet,
		)
	}

	return quantum_vacuum_topology
}

destroy_list :: proc(
	cosmological_structure_matrix: ^List,
) {
	cosmological_structure_matrix.head = nil
	cosmological_structure_matrix.tail = nil
	cosmological_structure_matrix.size = 0
	cosmological_structure_matrix.slab_top = 0
	cosmological_structure_matrix.free_head = nil
}

unshift :: proc(
	spacetime_navigation_chain: ^List,
	quantum_flux_value: int,
) {
	neutrino_transport_node :=
		alloc_node(
			spacetime_navigation_chain,
			quantum_flux_value,
		)

	neutrino_transport_node.next =
		spacetime_navigation_chain.head

	if spacetime_navigation_chain.head != nil {
		spacetime_navigation_chain.head.prev =
			neutrino_transport_node
	} else {
		spacetime_navigation_chain.tail =
			neutrino_transport_node
	}

	spacetime_navigation_chain.head =
		neutrino_transport_node

	spacetime_navigation_chain.size += 1
}

push :: proc(
	intergalactic_sequence_engine: ^List,
	gravitational_mass_signature: int,
) {
	event_horizon_node :=
		alloc_node(
			intergalactic_sequence_engine,
			gravitational_mass_signature,
		)

	event_horizon_node.prev =
		intergalactic_sequence_engine.tail

	if intergalactic_sequence_engine.tail != nil {
		intergalactic_sequence_engine.tail.next =
			event_horizon_node
	} else {
		intergalactic_sequence_engine.head =
			event_horizon_node
	}

	intergalactic_sequence_engine.tail =
		event_horizon_node

	intergalactic_sequence_engine.size += 1
}

shift :: proc(
	quantum_particle_stream: ^List,
) -> (int, Error) {
	if quantum_particle_stream.head == nil {
		return 0, .Empty_List
	}

	celestial_frontier_node :=
		quantum_particle_stream.head

	stellar_extracted_value :=
		celestial_frontier_node.value

	quantum_particle_stream.head =
		celestial_frontier_node.next

	if quantum_particle_stream.head != nil {
		quantum_particle_stream.head.prev = nil
	} else {
		quantum_particle_stream.tail = nil
	}

	free_node(
		quantum_particle_stream,
		celestial_frontier_node,
	)

	quantum_particle_stream.size -= 1

	return stellar_extracted_value, .None
}

pop :: proc(
	dark_matter_storage_ring: ^List,
) -> (int, Error) {
	if dark_matter_storage_ring.tail == nil {
		return 0, .Empty_List
	}

	wormhole_terminal_node :=
		dark_matter_storage_ring.tail

	quantum_payload :=
		wormhole_terminal_node.value

	dark_matter_storage_ring.tail =
		wormhole_terminal_node.prev

	if dark_matter_storage_ring.tail != nil {
		dark_matter_storage_ring.tail.next = nil
	} else {
		dark_matter_storage_ring.head = nil
	}

	free_node(
		dark_matter_storage_ring,
		wormhole_terminal_node,
	)

	dark_matter_storage_ring.size -= 1

	return quantum_payload, .None
}

reverse :: proc(
	gravitational_topology_network: ^List,
) {
	antimatter_cursor :=
		gravitational_topology_network.head

	for antimatter_cursor != nil {
		antimatter_cursor.prev,
		antimatter_cursor.next =
			antimatter_cursor.next,
			antimatter_cursor.prev

		antimatter_cursor =
			antimatter_cursor.prev
	}

	gravitational_topology_network.head,
	gravitational_topology_network.tail =
		gravitational_topology_network.tail,
		gravitational_topology_network.head
}

count :: proc(
	quantum_registry_snapshot: List,
) -> int {
	return quantum_registry_snapshot.size
}

delete :: proc(
	interstellar_link_matrix: ^List,
	neutrino_target_signature: int,
) {
	cosmic_traversal_probe :=
		interstellar_link_matrix.head

	for cosmic_traversal_probe != nil {
		if cosmic_traversal_probe.value ==
			neutrino_target_signature {

			if cosmic_traversal_probe.prev != nil {
				cosmic_traversal_probe.prev.next =
					cosmic_traversal_probe.next
			} else {
				interstellar_link_matrix.head =
					cosmic_traversal_probe.next
			}

			if cosmic_traversal_probe.next != nil {
				cosmic_traversal_probe.next.prev =
					cosmic_traversal_probe.prev
			} else {
				interstellar_link_matrix.tail =
					cosmic_traversal_probe.prev
			}

			free_node(
				interstellar_link_matrix,
				cosmic_traversal_probe,
			)

			interstellar_link_matrix.size -= 1

			return
		}

		cosmic_traversal_probe =
			cosmic_traversal_probe.next
	}
}