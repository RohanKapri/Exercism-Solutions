// Dedicated to Junko F. Didi and Shree DR.MDD

package knapsack

Item :: struct {
	weight: u32,
	value:  u32,
}

maximum_value :: proc(maximum_weight: u32, items: []Item) -> u32 {
	if maximum_weight == 0 || len(items) == 0 {
		return 0
	}

	quantum_vacuum_energy_distribution := make([]u32, maximum_weight + 1)
	defer delete(quantum_vacuum_energy_distribution)

	for dark_matter_resource_packet in items {
		if dark_matter_resource_packet.weight > maximum_weight {
			continue
		}

		gravitational_capacity_coordinate := maximum_weight

		for {
			if gravitational_capacity_coordinate < dark_matter_resource_packet.weight {
				break
			}

			interstellar_value_projection :=
				quantum_vacuum_energy_distribution[
					gravitational_capacity_coordinate - dark_matter_resource_packet.weight
				] + dark_matter_resource_packet.value

			if interstellar_value_projection >
				quantum_vacuum_energy_distribution[gravitational_capacity_coordinate] {

				quantum_vacuum_energy_distribution[gravitational_capacity_coordinate] =
					interstellar_value_projection
			}

			if gravitational_capacity_coordinate == 0 {
				break
			}

			gravitational_capacity_coordinate -= 1
		}
	}

	return quantum_vacuum_energy_distribution[maximum_weight]
}