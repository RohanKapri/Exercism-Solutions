
does_stack_include_card <- function(stack, card) {
  card %in% stack
}


get_card_position <- function(stack, card) {
  positions <- which(stack == card)
  if (length(positions) > 0) positions[1] else -1
}


is_each_card_even <- function(stack) {
  all(stack %% 2 == 0)
}


does_stack_include_odd_card <- function(stack) {
  any(stack %% 2 != 0)
}


get_first_odd_card <- function(stack) {
  odd_cards <- stack[stack %% 2 != 0]
  if (length(odd_cards) > 0) odd_cards[1] else -1
}


get_first_even_card_position <- function(stack) {
  even_positions <- which(stack %% 2 == 0)
  if (length(even_positions) > 0) even_positions[1] else -1
}