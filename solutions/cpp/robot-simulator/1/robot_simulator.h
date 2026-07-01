#ifndef ROBOT_SIMULATOR_H
#define ROBOT_SIMULATOR_H
#include <utility>
#include <string>
namespace robot_simulator {
  using namespace std;
  enum class Bearing {
    NORTH,
    SOUTH,
    EAST,
    WEST
  };
  class Robot {
   public:
    Robot()
      : x(0), y(0), bearing(Bearing::NORTH) {
    }
    Robot(pair<int, int> position, Bearing bearing)
      : x(position.first), y(position.second), bearing(bearing) {
    }
    auto get_position() const -> pair<int, int>;
    auto get_bearing() const -> Bearing;
    auto turn_right() -> void;
    auto turn_left() -> void;
    auto advance() -> void;
    auto execute_sequence(const string &sequence) -> void;
   private:
    int x;
    int y;
    Bearing bearing;
  };
}
#endif
