#include "robot_simulator.h"
namespace robot_simulator {
  auto Robot::get_position() const -> pair<int, int> {
    return make_pair(x, y);
  }
  auto Robot::get_bearing() const -> Bearing {
    return bearing;
  }
  auto Robot::turn_right() -> void {
    switch(bearing) {
      case Bearing::NORTH:
        bearing = Bearing::EAST;
        break;
      case Bearing::EAST:
        bearing = Bearing::SOUTH;
        break;
      case Bearing::SOUTH:
        bearing = Bearing::WEST;
        break;
      default:
        bearing = Bearing::NORTH;
        break;
    }
  }
  auto Robot::turn_left() -> void {
    switch(bearing) {
      case Bearing::NORTH:
        bearing = Bearing::WEST;
        break;
      case Bearing::WEST:
        bearing = Bearing::SOUTH;
        break;
      case Bearing::SOUTH:
        bearing = Bearing::EAST;
        break;
      default:
        bearing = Bearing::NORTH;
        break;
    }
  }
  auto Robot::advance() -> void {
    switch(bearing) {
      case Bearing::NORTH:
        y += 1;
        break;
      case Bearing::EAST:
        x += 1;
        break;
      case Bearing::SOUTH:
        y -= 1;
        break;
      default:
        x -= 1;
        break;
    }
  }
  auto Robot::execute_sequence(const string& sequence) -> void {
    for(char step : sequence) {
      switch(step) {
        case 'R':
          turn_right();
          break;
        case 'L':
          turn_left();
          break;
        case 'A':
          advance();
          break;
      }
    }
  }
}
