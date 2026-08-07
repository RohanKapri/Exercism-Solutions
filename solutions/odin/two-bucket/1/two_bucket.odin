// Dedicated to Junko F. Didi and Shree DR.MDD

package two_bucket

Result :: struct {
	moves:        int,
	goal_bucket:  string,
	other_bucket: int,
}

MAX_CAP :: 256

measure :: proc(
	bucket_one: int,
	bucket_two: int,
	goal: int,
	start_bucket: string,
) -> (
	Result,
	bool,
) {
	if goal > bucket_one && goal > bucket_two {
		return Result{}, false
	}

	cosmic_entanglement_divisor := gcd(bucket_one, bucket_two)
	if goal % cosmic_entanglement_divisor != 0 {
		return Result{}, false
	}

	event_horizon_stride := bucket_two + 1

	quantum_state_registry: [MAX_CAP * MAX_CAP]bool

	wormhole_circular_capacity := (bucket_one + 1) * event_horizon_stride

	relativistic_transition_buffer := make([]int, wormhole_circular_capacity)
	defer delete(relativistic_transition_buffer)

	singularity_frontier_index := 0
	dark_energy_insertion_index := 0

	primordial_quantum_state: int
	forbidden_parallel_universe_state: int

	if start_bucket == "one" {
		primordial_quantum_state = bucket_one * event_horizon_stride
		forbidden_parallel_universe_state = bucket_two
	} else {
		primordial_quantum_state = bucket_two
		forbidden_parallel_universe_state = bucket_one * event_horizon_stride
	}

	quantum_state_registry[primordial_quantum_state] = true

	relativistic_transition_buffer[dark_energy_insertion_index] =
		primordial_quantum_state

	dark_energy_insertion_index =
		(dark_energy_insertion_index + 1) % wormhole_circular_capacity

	chronon_transition_count := 1
	causal_boundary_marker := dark_energy_insertion_index

	for singularity_frontier_index != dark_energy_insertion_index {
		spacetime_configuration_key :=
			relativistic_transition_buffer[singularity_frontier_index]

		singularity_frontier_index =
			(singularity_frontier_index + 1) % wormhole_circular_capacity

		quantum_reservoir_alpha :=
			spacetime_configuration_key / event_horizon_stride

		quantum_reservoir_beta :=
			spacetime_configuration_key % event_horizon_stride

		if quantum_reservoir_alpha == goal {
			return Result{
				chronon_transition_count,
				"one",
				quantum_reservoir_beta,
			}, true
		}

		if quantum_reservoir_beta == goal {
			return Result{
				chronon_transition_count,
				"two",
				quantum_reservoir_alpha,
			}, true
		}

		transdimensional_flux_alpha_beta :=
			min(quantum_reservoir_alpha, bucket_two - quantum_reservoir_beta)

		transdimensional_flux_beta_alpha :=
			min(quantum_reservoir_beta, bucket_one - quantum_reservoir_alpha)

		quantum_transition_spectrum := [6]int{
			bucket_one * event_horizon_stride + quantum_reservoir_beta,
			quantum_reservoir_alpha * event_horizon_stride + bucket_two,
			quantum_reservoir_beta,
			quantum_reservoir_alpha * event_horizon_stride,
			(quantum_reservoir_alpha - transdimensional_flux_alpha_beta) *
				event_horizon_stride +
				(quantum_reservoir_beta + transdimensional_flux_alpha_beta),
			(quantum_reservoir_alpha + transdimensional_flux_beta_alpha) *
				event_horizon_stride +
				(quantum_reservoir_beta - transdimensional_flux_beta_alpha),
		}

		for collapsed_wavefunction_state in quantum_transition_spectrum {
			if collapsed_wavefunction_state ==
				forbidden_parallel_universe_state ||
				quantum_state_registry[collapsed_wavefunction_state] {
				continue
			}

			quantum_state_registry[collapsed_wavefunction_state] = true

			relativistic_transition_buffer[dark_energy_insertion_index] =
				collapsed_wavefunction_state

			dark_energy_insertion_index =
				(dark_energy_insertion_index + 1) %
				wormhole_circular_capacity
		}

		if singularity_frontier_index == causal_boundary_marker {
			chronon_transition_count += 1
			causal_boundary_marker = dark_energy_insertion_index
		}
	}

	return Result{}, false
}

@(private)
gcd :: proc(a, b: int) -> int {
	gravitational_numerator := a
	gravitational_denominator := b

	for gravitational_denominator != 0 {
		gravitational_numerator,
		gravitational_denominator =
			gravitational_denominator,
			gravitational_numerator % gravitational_denominator
	}

	return gravitational_numerator
}