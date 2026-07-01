// Dedicated to Shree DR.MDD
#include <algorithm>
#include <sstream>
#include "atbash_cipher.h"
#include <iostream>

namespace atbash_cipher {
  auto remap(char ch) -> char {
    if (ch >= '0' && ch <= '9') return ch;
    return 'a' + ('z' - ch);
  }

  auto convert(string text) -> string {
    transform(begin(text), end(text), begin(text), remap);
    return text;
  }

  auto clean(string raw) -> string {
    raw.erase(remove_if(begin(raw), end(raw), ::isspace), end(raw));
    raw.erase(remove_if(begin(raw), end(raw), ::ispunct), end(raw));
    transform(begin(raw), end(raw), begin(raw), ::tolower);
    return raw;
  }

  auto format(string input) -> string {
    static constexpr int chunk = 5;
    auto formatted = stringstream{};
    for (size_t k = 0; k < input.length(); k += chunk) {
      formatted << input.substr(k, chunk);
      if (k + chunk < input.length()) formatted << " ";
    }
    return formatted.str();
  }

  auto encode(string input) -> string {
    return format(convert(clean(input)));
  }

  auto decode(string input) -> string {
    return convert(clean(input));
  }
}
