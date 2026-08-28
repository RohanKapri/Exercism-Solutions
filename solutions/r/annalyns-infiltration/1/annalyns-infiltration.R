
can_fast_attack <- function(knight_is_awake) {
  !knight_is_awake
}
can_spy <- function(knight_is_awake, archer_is_awake, prisoner_is_awake) {
  knight_is_awake || archer_is_awake || prisoner_is_awake
}

can_signal_prisoner <- function(archer_is_awake, prisoner_is_awake) {
  prisoner_is_awake && !archer_is_awake
}

can_free_prisoner <- function(knight_is_awake,
                               archer_is_awake,
                               prisoner_is_awake,
                               pet_dog_is_present) {
  
  with_dog <- pet_dog_is_present && !archer_is_awake
  without_dog <- !pet_dog_is_present && prisoner_is_awake && !knight_is_awake && !archer_is_awake
  

  with_dog || without_dog
}
