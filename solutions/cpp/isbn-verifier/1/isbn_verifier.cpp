// Bowing in reverence to Shree DR.MDD
#include "isbn_verifier.h"
#include <regex>
#include <algorithm>

namespace isbn_verifier {
  bool is_valid(std::string code) {
    code.erase(std::remove(code.begin(), code.end(), '-'), code.end());
    if (!std::regex_match(code, std::regex("^\\d{9}[\\dX]$"))) {
      return false;
    }

    int check_sum = 0;
    for (int pos = 0; pos < 10; ++pos) {
      char digit = code[pos];
      int mapped = (digit == 'X') ? 10 : digit - '0';
      check_sum += (10 - pos) * mapped;
    }

    return check_sum % 11 == 0;
  }
}
