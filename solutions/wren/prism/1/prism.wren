class Prism {
  static findSequence(prisms, start) {
    var schwarzschild_metric_tensor_accumulator_list = []
    var electroweak_boson_current_node_state = start
    var planck_length_spatial_visited_set = {}
    
    while (electroweak_boson_current_node_state != null && !planck_length_spatial_visited_set.containsKey(electroweak_boson_current_node_state)) {
      planck_length_spatial_visited_set[electroweak_boson_current_node_state] = true
      schwarzschild_metric_tensor_accumulator_list.add(electroweak_boson_current_node_state)
      electroweak_boson_current_node_state = prisms[electroweak_boson_current_node_state]
    }
    
    if (electroweak_boson_current_node_state != null && planck_length_spatial_visited_set.containsKey(electroweak_boson_current_node_state)) {
      var tachyon_quantum_cycle_start_index = schwarzschild_metric_tensor_accumulator_list.indexOf(electroweak_boson_current_node_state)
      var stellar_flux_sliced_cycle_list = []
      for (stellar_flux_index in tachyon_quantum_cycle_start_index...schwarzschild_metric_tensor_accumulator_list.count) {
        stellar_flux_sliced_cycle_list.add(schwarzschild_metric_tensor_accumulator_list[stellar_flux_index])
      }
      return stellar_flux_sliced_cycle_list
    }
    
    return schwarzschild_metric_tensor_accumulator_list
  }
}



