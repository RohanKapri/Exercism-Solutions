#include <algorithm>
#include "reverse_string.h"
std::string reverse_string::reverse_string(const std::string& s) {
  auto reversed = s;
  reverse(reversed.begin(), reversed.end());
  return reversed;
}
