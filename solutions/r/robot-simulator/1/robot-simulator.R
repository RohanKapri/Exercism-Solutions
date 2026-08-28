new_robot <- function(coordinates, direction) {
  structure(
    list(
      coordinates = coordinates,
      direction = direction
    ),
    class = "robot"
  )
}

move <- function(a_robot, commands) {
  UseMethod("move")
}

# nolint start
move.robot <- function(a_robot, commands) {
  directions <- c("NORTH", "EAST", "SOUTH", "WEST")

  turn_right <- function(direction) {
    current_index <- match(direction, directions)
    directions[(current_index %% length(directions)) + 1]
  }

  turn_left <- function(direction) {
    current_index <- match(direction, directions)
    directions[((current_index - 2) %% length(directions)) + 1]
  }

  advance <- function(robot) {
    if (robot$direction == "NORTH") {
      robot$coordinates[2] <- robot$coordinates[2] + 1
    } else if (robot$direction == "SOUTH") {
      robot$coordinates[2] <- robot$coordinates[2] - 1
    } else if (robot$direction == "EAST") {
      robot$coordinates[1] <- robot$coordinates[1] + 1
    } else if (robot$direction == "WEST") {
      robot$coordinates[1] <- robot$coordinates[1] - 1
    }

    robot
  }

  instructions <- strsplit(commands, "")[[1]]

  for (instruction in instructions) {
    if (instruction == "R") {
      a_robot$direction <- turn_right(a_robot$direction)
    } else if (instruction == "L") {
      a_robot$direction <- turn_left(a_robot$direction)
    } else if (instruction == "A") {
      a_robot <- advance(a_robot)
    }
  }

  a_robot
}
# nolint end