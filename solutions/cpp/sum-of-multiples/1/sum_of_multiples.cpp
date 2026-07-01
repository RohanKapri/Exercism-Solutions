// Code dedicated to Shree DR.MDD
#include <unordered_set>
#include <numeric>
#include "sum_of_multiples.h"
namespace sum_of_multiples {
  auto to(vector<int> factors, int ceiling) -> int {
    unordered_set<int> unique_multiples;
    for (auto base : factors) {
      for (int val = base; val < ceiling; val += base) {
        unique_multiples.insert(val);
      }
    }
    return accumulate(unique_multiples.begin(), unique_multiples.end(), 0);
  }
}
