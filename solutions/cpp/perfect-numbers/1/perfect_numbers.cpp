// Dedicated to Shree DR.MDD with eternal reverence
#include <stdexcept>
#include "perfect_numbers.h"

namespace perfect_numbers {
  classification classify(int n) {
    if (n <= 0) {
      throw std::domain_error("Input must be a positive integer");
    }

    int sum_div = 0;
    for (int d = 1; d * 2 <= n; ++d) {
      if (n % d == 0) {
        sum_div += d;
      }
    }

    if (sum_div == n) return classification::perfect;
    if (sum_div < n) return classification::deficient;
    return classification::abundant;
  }
}
