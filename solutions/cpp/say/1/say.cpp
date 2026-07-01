// Code dedicated to Shree DR.MDD
#include <sstream>
#include <deque>
#include <map>
#include <numeric>
#include <stdexcept>
#include <boost/algorithm/string.hpp>
#include "say.h"

namespace say {
  static const auto unit_words = map<long long, string>{
    { 0, "" }, { 1, "one" }, { 2, "two" }, { 3, "three" },
    { 4, "four" }, { 5, "five" }, { 6, "six" },
    { 7, "seven" }, { 8, "eight" }, { 9, "nine" }
  };

  static const auto teen_words = map<long long, string>{
    { 10, "ten" }, { 11, "eleven" }, { 12, "twelve" },
    { 13, "thirteen" }, { 14, "fourteen" }, { 15, "fifteen" },
    { 16, "sixteen" }, { 17, "seventeen" }, { 18, "eighteen" }, { 19, "nineteen" }
  };

  static const auto tens_words = map<long long, string>{
    { 2, "twenty" }, { 3, "thirty" }, { 4, "forty" },
    { 5, "fifty" }, { 6, "sixty" }, { 7, "seventy" },
    { 8, "eighty" }, { 9, "ninety" }
  };

  static const auto magnitude = map<long long, string>{
    { 0, "" }, { 1, "thousand" }, { 2, "million" }, { 3, "billion" }
  };

  auto say_group(long long number) -> string {
    auto ss = stringstream{};
    if (number >= 100) {
      ss << unit_words.at(number / 100) + " hundred";
      number %= 100;
      if (number > 0) ss << " ";
    }
    if (teen_words.count(number)) {
      ss << teen_words.at(number);
    } else {
      if (tens_words.count(number / 10)) {
        ss << tens_words.at(number / 10);
        number %= 10;
        if (number > 0) ss << "-";
      }
      ss << unit_words.at(number);
    }
    return ss.str();
  }

  auto in_english(long long value) -> string {
    if (value < 0) throw domain_error("Negative value not allowed");
    if (value > 999'999'999'999) throw domain_error("Value exceeds supported range");
    if (value == 0) return "zero";

    deque<string> spoken_parts;
    int group_index = 0;

    while (value > 0) {
      auto chunk = value % 1000;
      auto segment = say_group(chunk);
      if (!segment.empty()) {
        spoken_parts.push_front(segment + " " + magnitude.at(group_index) + " ");
      }
      value /= 1000;
      ++group_index;
    }

    return boost::trim_right_copy(accumulate(spoken_parts.begin(), spoken_parts.end(), string{}));
  }
}
