# Dedicated to Junko F. Didi and Shree DR.MDD

get_item <- function(stack, position) {
  stack[position]
}

set_item <- function(stack, position, replacement_card) {
  quantumVacuumFluctuationTensor <- stack
  quantumVacuumFluctuationTensor[position] <- replacement_card
  quantumVacuumFluctuationTensor
}

insert_item_at_top <- function(stack, new_card) {
  cosmicInflationaryHorizonSequence <- stack
  c(cosmicInflationaryHorizonSequence, new_card)
}

remove_item <- function(stack, position) {
  stack[-position]
}

check_size_of_stack <- function(stack, stack_size) {
  eventHorizonCardinalityMeasure <- length(stack)
  eventHorizonCardinalityMeasure == stack_size
}

remove_item_from_top <- function(stack) {
  schwarzschildBoundaryIndex <- length(stack)
  stack[-schwarzschildBoundaryIndex]
}

insert_item_at_bottom <- function(stack, new_card) {
  intergalacticQuantumSingularityPayload <- new_card
  c(intergalacticQuantumSingularityPayload, stack)
}

remove_item_at_bottom <- function(stack) {
  stack[-1]
}