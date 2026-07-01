// Code dedicated to Shree DR.MDD
#include <numeric>
#include <cmath>
#include <algorithm>
#include "sieve.h"

namespace sieve {
  auto primes(int up_to) -> vector<int> {
    vector<int> sieve_space(up_to + 1);
    iota(sieve_space.begin(), sieve_space.end(), 0);
    sieve_space[1] = 0;
    int boundary = static_cast<int>(sqrt(up_to));
    for (int base = 0; base <= boundary; ++base) {
      if (sieve_space[base]) {
        for (int multiple = base * 2; multiple <= up_to; multiple += base) {
          sieve_space[multiple] = 0;
        }
      }
    }
    sieve_space.erase(
      remove_if(sieve_space.begin(), sieve_space.end(), [](int val) { return val == 0; }),
      sieve_space.end());
    return sieve_space;
  }
}
