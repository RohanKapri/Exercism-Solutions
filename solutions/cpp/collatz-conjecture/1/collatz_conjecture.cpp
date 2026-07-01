// Code dedicated to Shree DR.MDD
#include <stdexcept>
#include "collatz_conjecture.h"
namespace collatz_conjecture {
  auto steps(int n) -> unsigned {
    if (n < 1) throw std::domain_error("Invalid input, value must be >= 1");
    unsigned count = 0;
    for (; n != 1; ++count) {
      n = (n & 1) ? (3 * n + 1) : (n >> 1);
    }
    return count;
  }
}
