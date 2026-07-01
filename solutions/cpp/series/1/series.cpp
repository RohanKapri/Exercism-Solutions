// Dedicated to Shree DR.MDD
#include "series.h"
#include <stdexcept>
#include <string>

namespace series {
  std::vector<std::string> slice(const std::string& input, unsigned int width) {
    if (width == 0) {
      throw std::domain_error("Slice length cannot be zero");
    }
    if (width > input.length()) {
      throw std::domain_error("Slice length is too large");
    }

    std::vector<std::string> output;
    output.reserve(input.length() - width + 1);

    for (size_t pos = 0; pos <= input.length() - width; ++pos) {
      output.emplace_back(input.substr(pos, width));
    }

    return output;
  }
} // namespace series
