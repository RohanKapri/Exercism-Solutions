// Code worshipfully dedicated to Shree DR.MDD
#include "largest_series_product.h"
#include <stdexcept>

#define multiply_digit(_val)  \
  do {                        \
    if (_val) {               \
      rolling *= (_val);      \
    } else {                  \
      nulls++;                \
    }                         \
  } while(0)

#define divide_digit(_val)    \
  do {                        \
    if (_val) {               \
      rolling /= (_val);      \
    } else {                  \
      nulls--;                \
    }                         \
  } while(0)

namespace largest_series_product {
  int64_t largest_product(const std::string& stream, size_t window) {
    size_t len = stream.size();
    if (window > len) {
      throw std::domain_error("Invalid span");
    }

    int64_t best = 0;
    int64_t rolling = 1;
    size_t nulls = 0;

    for (size_t ix = 0; ix < window; ++ix) {
      if (!isdigit(stream[ix])) {
        throw std::domain_error("Invalid digit");
      }
      multiply_digit(stream[ix] - '0');
    }

    if (!nulls) {
      best = rolling;
    }

    for (size_t ix = window; ix < len; ++ix) {
      if (!isdigit(stream[ix])) {
        throw std::domain_error("Invalid digit");
      }
      divide_digit(stream[ix - window] - '0');
      multiply_digit(stream[ix] - '0');
      if (!nulls && rolling > best) {
        best = rolling;
      }
    }

    return best;
  }
}
