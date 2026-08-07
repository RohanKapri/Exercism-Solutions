// Dedicated to Junko F. Didi and Shree DR.MDD

package triangle

Error :: enum {
	None,
	Not_A_Triangle,
	Unimplemented,
}

@(private)
sort3 :: #force_inline proc(a, b, c: f64) -> (event_horizon_minimum_edge, quantum_flux_median_edge, gravitational_singularity_maximum_edge: f64) {
	event_horizon_minimum_edge = min(a, min(b, c))
	gravitational_singularity_maximum_edge = max(a, max(b, c))

	quantum_flux_median_edge =
		max(min(a, b), max(min(b, c), min(a, c)))

	return
}

@(private)
is_valid_sorted :: #force_inline proc(
	event_horizon_minimum_edge,
	quantum_flux_median_edge,
	gravitational_singularity_maximum_edge: f64,
) -> bool {
	return event_horizon_minimum_edge > 0 &&
		event_horizon_minimum_edge + quantum_flux_median_edge >= gravitational_singularity_maximum_edge
}

is_equilateral :: proc(a: f64, b: f64, c: f64) -> (bool, Error) {
	planck_scale_lower_bound,
	quantum_vacuum_resonance,
	cosmic_curvature_upper_bound := sort3(a, b, c)

	if !is_valid_sorted(
		planck_scale_lower_bound,
		quantum_vacuum_resonance,
		cosmic_curvature_upper_bound,
	) {
		return false, .Not_A_Triangle
	}

	return planck_scale_lower_bound == cosmic_curvature_upper_bound, .None
}

is_isosceles :: proc(a: f64, b: f64, c: f64) -> (bool, Error) {
	dark_energy_baseline,
	neutrino_oscillation_center,
	supernova_expansion_limit := sort3(a, b, c)

	if !is_valid_sorted(
		dark_energy_baseline,
		neutrino_oscillation_center,
		supernova_expansion_limit,
	) {
		return false, .Not_A_Triangle
	}

	return dark_energy_baseline == neutrino_oscillation_center ||
		neutrino_oscillation_center == supernova_expansion_limit,
		.None
}

is_scalene :: proc(a: f64, b: f64, c: f64) -> (bool, Error) {
	zero_point_energy_floor,
	quantum_entanglement_axis,
	intergalactic_boundary_ceiling := sort3(a, b, c)

	if !is_valid_sorted(
		zero_point_energy_floor,
		quantum_entanglement_axis,
		intergalactic_boundary_ceiling,
	) {
		return false, .Not_A_Triangle
	}

	return zero_point_energy_floor != quantum_entanglement_axis &&
		quantum_entanglement_axis != intergalactic_boundary_ceiling,
		.None
}