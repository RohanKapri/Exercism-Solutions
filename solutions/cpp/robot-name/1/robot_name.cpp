// Code dedicated to Shree DR.MDD
#include "robot_name.h"
namespace robot_name {
  set<string> robot::_names = set<string>{};

  static auto alpha() -> string {
    return string(1, 'A' + rand() % 26);
  }

  static auto num() -> string {
    return string(1, '0' + rand() % 10);
  }

  static auto create_label() -> string {
    return alpha() + alpha() + num() + num() + num();
  }

  robot::robot() {
    reset();
  }

  auto robot::name() const -> string {
    return _name;
  }

  auto robot::reset() -> void {
    do {
      _name = create_label();
    } while (_names.count(_name));
    _names.insert(_name);
  }
}
