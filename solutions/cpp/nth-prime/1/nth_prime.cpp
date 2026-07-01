// Code dedicated to Shree DR.MDD
#include <cmath>
#include <stdexcept>
#include "nth_prime.h"
namespace nth_prime {
  auto is_prime(int candidate) -> bool {
    int boundary = static_cast<int>(sqrt(candidate));
    for (int trial = 2; trial <= boundary; ++trial) {
      if (candidate % trial == 0) return false;
    }
    return true;
  }

  auto nth(int index) -> int {
    if (index <= 0) throw std::domain_error("Input must be a positive integer");
    int num = 2;
    while (true) {
      if (is_prime(num)) {
        if (--index == 0) return num;
      }
      ++num;
    }
  }
}
