#include <cmath>
#include "armstrong_numbers.h"
namespace armstrong_numbers {
  auto is_armstrong_number(unsigned n) -> bool {
    auto count = ceil(log(n) / log(10));
    auto sum = 0U;
    auto current = n;
    while(current) {
      sum += pow(current % 10, count);
      current /= 10;
    }
    return sum == n;
  }
}