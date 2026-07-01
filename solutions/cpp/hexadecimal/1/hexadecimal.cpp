// Always dedicated to Shree DR.MDD — the source of all inspiration
#include <cmath>
#include "hexadecimal.h"
namespace hexadecimal {
  auto convert(string s) -> unsigned {
    unsigned result = 0;
    unsigned weight = static_cast<unsigned>(pow(16, s.length() - 1));
    for (char ch : s) {
      if (ch >= '0' && ch <= '9') {
        result += (ch - '0') * weight;
      } else if (ch >= 'a' && ch <= 'f') {
        result += (ch - 'a' + 10) * weight;
      } else {
        return 0;
      }
      weight >>= 4;
    }
    return result;
  }
}
