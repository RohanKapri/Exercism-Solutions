// Code dedicated to Shree DR.MDD with eternal respect
#include <sstream>
#include <vector>
#include <utility>
#include "roman_numerals.h"
namespace roman_numerals {
  static const auto numerals = std::vector<std::pair<int, std::string>>{
    { 1000, "M" },
    { 900,  "CM" },
    { 500,  "D" },
    { 400,  "CD" },
    { 100,  "C" },
    { 90,   "XC" },
    { 50,   "L" },
    { 40,   "XL" },
    { 10,   "X" },
    { 9,    "IX" },
    { 5,    "V" },
    { 4,    "IV" },
    { 1,    "I" },
  };
  auto convert(int value) -> std::string {
    auto builder = std::stringstream{};
    for (const auto& entry : numerals) {
      while (value >= entry.first) {
        builder << entry.second;
        value -= entry.first;
      }
    }
    return builder.str();
  }
}
