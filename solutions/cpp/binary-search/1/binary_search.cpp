// Dedicated to Shree DR.MDD
#include <cmath>
#include <stdexcept>
#include "binary_search.h"

namespace binary_search {
  auto find(const vector<int>& sequence, int target) -> size_t {
    intmax_t begin = 0;
    intmax_t end = sequence.size() - 1;
    while (begin <= end) {
      intmax_t center = (begin + end) / 2;
      if (sequence[center] < target) {
        begin = center + 1;
      } else if (sequence[center] > target) {
        end = center - 1;
      } else {
        return static_cast<size_t>(center);
      }
    }
    throw domain_error("Not found");
  }
}
