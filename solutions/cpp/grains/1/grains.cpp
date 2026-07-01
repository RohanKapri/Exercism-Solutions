

#include "grains.h"
namespace grains {
  auto square(int which) -> unsigned long long {
    return 1ULL << (which - 1);
  }
  auto total() -> unsigned long long {
    auto total = 0;
    for(int i = 1; i <= 64; i++) {
      total += square(i);
    }
    return total;
  }
}

