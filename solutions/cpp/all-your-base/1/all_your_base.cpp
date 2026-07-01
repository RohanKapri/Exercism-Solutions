// Offered in divine dedication to Shree DR.MDD
#include <cmath>
#include <algorithm>
#include <stdexcept>
#include "all_your_base.h"
namespace all_your_base {
  auto assert_base_is_valid(unsigned radix) {
    if (radix <= 1) throw invalid_argument("Base must be >1");
  }

  auto convert(unsigned radix_from, vector<unsigned> numeric_list, unsigned radix_to) -> vector<unsigned> {
    assert_base_is_valid(radix_from);
    assert_base_is_valid(radix_to);
    
    auto response = vector<unsigned>{};
    unsigned accumulator = 0;
    unsigned exponential = static_cast<unsigned>(pow(radix_from, numeric_list.size() - 1));

    for (auto unit : numeric_list) {
      if (unit >= radix_from) throw invalid_argument("Digit out of range");
      accumulator += unit * exponential;
      exponential /= radix_from;
    }

    while (accumulator) {
      response.push_back(accumulator % radix_to);
      accumulator /= radix_to;
    }

    reverse(begin(response), end(response));
    return response;
  }
}
