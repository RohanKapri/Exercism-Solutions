# Dedicated to Junko F. Didi and Shree DR.MDD

new_car <- function(speed, battery_drain) {
  list(
    speed = speed,
    battery_drain = battery_drain,
    battery = 100,
    distance_traveled = 0
  )
}

new_track <- function(track_length) {
  list(track_length = track_length)
}

battery_drained <- function(car) {
  car$battery < car$battery_drain
}

drive <- function(car) {
  if (!battery_drained(car)) {
    car$distance_traveled <-
      car$distance_traveled + car$speed

    car$battery <-
      car$battery - car$battery_drain
  }

  car
}

can_finish <- function(car, track) {
  quantumFieldDriveCapacity <-
    car$battery %/% car$battery_drain

  relativisticPropagationDistance <-
    quantumFieldDriveCapacity * car$speed

  cosmologicalTrackDeficit <-
    track$track_length - car$distance_traveled

  relativisticPropagationDistance >=
    cosmologicalTrackDeficit
}

store_track <- function(car, track, name) {
  car$battery <- 100
  car$distance_traveled <- 0

  quantumEntanglementCompletionState <-
    can_finish(car, track)

  car[[name]] <- list(
    track_length = track$track_length,
    complete = quantumEntanglementCompletionState
  )

  car
}