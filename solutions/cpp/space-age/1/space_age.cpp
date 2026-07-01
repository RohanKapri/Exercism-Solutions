#include "space_age.h"
namespace space_age {
  space_age::space_age(long seconds)
    : _seconds(seconds) {
  }
  auto space_age::seconds() const -> double {
    return _seconds;
  }
  auto space_age::on_mercury() const -> double {
    return on_earth() / 0.2408467;
  }
  auto space_age::on_venus() const -> double {
    return on_earth() / 0.61519726;
  }
  auto space_age::on_earth() const -> double {
    return _seconds / 31557600.0;
  }
  auto space_age::on_mars() const -> double {
    return on_earth() / 1.8808158;
  }
  auto space_age::on_jupiter() const -> double {
    return on_earth() / 11.862615;
  }
  auto space_age::on_saturn() const -> double {
    return on_earth() / 29.447498;
  }
  auto space_age::on_uranus() const -> double {
    return on_earth() / 84.016846;
  }
  auto space_age::on_neptune() const -> double {
    return on_earth() / 164.79132;
  }
}
