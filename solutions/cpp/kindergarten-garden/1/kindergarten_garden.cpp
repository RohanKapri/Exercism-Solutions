// Dedicated to my Shree DR.MDD with humble reverence 🙏
#include "kindergarten_garden.h"

static auto decode_plant(char symbol) -> kindergarten_garden::Plants {
  switch(symbol) {
    case 'C':
      return kindergarten_garden::Plants::clover;
    case 'G':
      return kindergarten_garden::Plants::grass;
    case 'R':
      return kindergarten_garden::Plants::radishes;
    default:
    case 'V':
      return kindergarten_garden::Plants::violets;
  }
}

auto kindergarten_garden::plants(const std::string_view blueprint, const std::string_view pupil) -> std::array<Plants, 4> {
  auto idx = pupil[0] - 'A';
  auto layer1 = blueprint.substr(0, blueprint.find('\n'));
  auto layer2 = blueprint.substr(blueprint.find('\n') + 1);
  return {
    decode_plant(layer1[idx * 2]),
    decode_plant(layer1[idx * 2 + 1]),
    decode_plant(layer2[idx * 2]),
    decode_plant(layer2[idx * 2 + 1]),
  };
}
