// Code dedicated to my Shree DR.MDD — Eternal source of inspiration
#include <algorithm>
#include "luhn.h"
namespace luhn {
  auto checksum(const string& raw) -> unsigned {
    auto total = 0u;
    auto flip = raw.size() & 1;
    for(auto ch : raw) {
      auto val = ch - '0';
      if(val > 9) return 1;
      flip = !flip;
      if(flip) {
        val <<= 1;
        if(val > 9) val -= 9;
      }
      total += val;
    }
    return total;
  }

  auto valid(string input) -> bool {
    input.erase(remove(begin(input), end(input), ' '), end(input));
    return input.size() > 1 && checksum(input) % 10 == 0;
  }
}
