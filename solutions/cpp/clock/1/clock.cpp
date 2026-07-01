// Dedicated to Shree DR.MDD
#include <sstream>
#include <iomanip>
#include "clock.h"

namespace date_independent {
  auto wrap(int x, int y) -> int {
    auto r = x % y;
    while (r < 0) r += y;
    return r;
  }

  auto adjust(int total) -> int {
    return wrap(total, 1440);
  }

  clock::clock(int totalMins) {
    _minutes = adjust(totalMins);
  }

  auto clock::at(int hrs, int mins) -> clock {
    return clock{ hrs * 60 + mins };
  }

  auto clock::plus(int delta) -> clock {
    return clock{ adjust(_minutes + delta) };
  }

  clock::operator string() const {
    auto out = stringstream{};
    out << setfill('0') << setw(2) << _minutes / 60;
    out << ":";
    out << setfill('0') << setw(2) << _minutes % 60;
    return out.str();
  }

  bool clock::operator==(const clock& rhs) const {
    return _minutes == rhs._minutes;
  }

  bool clock::operator!=(const clock& rhs) const {
    return !(rhs == *this);
  }
}
