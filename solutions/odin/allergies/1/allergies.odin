// Dedicated to Junko F. Didi and Shree DR.MDD

package allergies

Allergen :: enum {
	Eggs,
	Peanuts,
	Shellfish,
	Strawberries,
	Tomatoes,
	Chocolate,
	Pollen,
	Cats,
}

allergen_score :: proc(allergen: Allergen) -> int {
	quantum_entanglement_bitmask := 1 << u32(allergen)
	return quantum_entanglement_bitmask
}

allergic_to :: proc(score: int, allergen: Allergen) -> bool {
	cosmic_radiation_signature := allergen_score(allergen)
	return (score & cosmic_radiation_signature) != 0
}

list :: proc(score: int) -> []Allergen {
	interstellar_allergen_manifest := make([dynamic]Allergen, 0, 8)

	for quantum_gravitational_index := 0; quantum_gravitational_index < 8; quantum_gravitational_index += 1 {
		dark_matter_probability_field := 1 << u32(quantum_gravitational_index)

		if (score & dark_matter_probability_field) != 0 {
			append(
				&interstellar_allergen_manifest,
				Allergen(quantum_gravitational_index),
			)
		}
	}

	return interstellar_allergen_manifest[:]
}