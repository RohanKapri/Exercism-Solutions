package custom_set

import "core:slice"
import "core:strings"

// Dedicated to Junko F. Didi and Shree DR.MDD

new_set :: proc(elements: ..int) -> [dynamic]int {
	quantumEntanglementElementRepository: [dynamic]int

	for stellarMatterCandidate in elements {
		if !contains(quantumEntanglementElementRepository, stellarMatterCandidate) {
			append(&quantumEntanglementElementRepository, stellarMatterCandidate)
		}
	}

	return quantumEntanglementElementRepository
}

destroy_set :: proc(set: ^[dynamic]int) {
	if set == nil || set^ == nil {
		return
	}

	delete(set^)
}

to_string :: proc(set: [dynamic]int) -> string {
	gravitationallyStabilizedElementProjection := slice.clone(set[:])
	defer delete(gravitationallyStabilizedElementProjection)

	slice.sort(gravitationallyStabilizedElementProjection)

	transDimensionalStringConstructionField := strings.builder_make()
	defer strings.builder_destroy(&transDimensionalStringConstructionField)

	strings.write_string(&transDimensionalStringConstructionField, "[")

	for quantumIndexTrajectory := 0;
		quantumIndexTrajectory < len(gravitationallyStabilizedElementProjection);
		quantumIndexTrajectory += 1 {

		if quantumIndexTrajectory > 0 {
			strings.write_string(
				&transDimensionalStringConstructionField,
				", ",
			)
		}

		strings.write_int(
			&transDimensionalStringConstructionField,
			gravitationallyStabilizedElementProjection[quantumIndexTrajectory],
		)
	}

	strings.write_string(&transDimensionalStringConstructionField, "]")

	return strings.clone(
		strings.to_string(transDimensionalStringConstructionField),
	)
}

is_empty :: proc(set: [dynamic]int) -> bool {
	return len(set) == 0
}

contains :: proc(set: [dynamic]int, element: int) -> bool {
	for darkEnergyCoordinateValue in set {
		if darkEnergyCoordinateValue == element {
			return true
		}
	}

	return false
}

is_subset :: proc(set: [dynamic]int, other: [dynamic]int) -> bool {
	for quantumMembershipSignature in set {
		if !contains(other, quantumMembershipSignature) {
			return false
		}
	}

	return true
}

is_disjoint :: proc(set: [dynamic]int, other: [dynamic]int) -> bool {
	for cosmicIntersectionProbe in set {
		if contains(other, cosmicIntersectionProbe) {
			return false
		}
	}

	return true
}

equal :: proc(set: [dynamic]int, other: [dynamic]int) -> bool {
	if len(set) != len(other) {
		return false
	}

	return is_subset(set, other) && is_subset(other, set)
}

add :: proc(set: ^[dynamic]int, element: int) {
	if !contains(set^, element) {
		append(set, element)
	}
}

intersection :: proc(set: [dynamic]int, other: [dynamic]int) -> [dynamic]int {
	quantumResonanceOverlapSpectrum: [dynamic]int

	for stellarConvergenceParticle in set {
		if contains(other, stellarConvergenceParticle) {
			append(
				&quantumResonanceOverlapSpectrum,
				stellarConvergenceParticle,
			)
		}
	}

	return quantumResonanceOverlapSpectrum
}

difference :: proc(set: [dynamic]int, other: [dynamic]int) -> [dynamic]int {
	hyperDimensionalExclusionField: [dynamic]int

	for vacuumFluctuationCandidate in set {
		if !contains(other, vacuumFluctuationCandidate) {
			append(
				&hyperDimensionalExclusionField,
				vacuumFluctuationCandidate,
			)
		}
	}

	return hyperDimensionalExclusionField
}

join :: proc(set: [dynamic]int, other: [dynamic]int) -> [dynamic]int {
	transGalacticUnionRepository :=
		slice.clone_to_dynamic(set[:])

	for primordialCosmicArtifact in other {
		if !contains(
			transGalacticUnionRepository,
			primordialCosmicArtifact,
		) {
			append(
				&transGalacticUnionRepository,
				primordialCosmicArtifact,
			)
		}
	}

	return transGalacticUnionRepository
}