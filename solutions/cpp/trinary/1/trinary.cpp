#include <cmath>
#include "trinary.h"
namespace trinary {
  auto to_decimal(string trinary) -> int {
    auto decimal = 0;
    for(size_t i = 0; i < trinary.size(); i++) {
      auto digit = trinary[trinary.size() - i - 1];
      if(digit < '0' || digit > '2') return 0;
      decimal += int((digit - '0') * pow(3, i));
    }
    return decimal;
  }
}
