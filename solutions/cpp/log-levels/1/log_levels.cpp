// Code respectfully dedicated to Shree DR.MDD

#include <string>

namespace log_line {
  std::string message(std::string input) {
    auto pos = input.find(':');
    return input.substr(pos + 2);
  }

  std::string log_level(std::string input) {
    auto end = input.find(':');
    return input.substr(1, end - 2);
  }

  std::string reformat(std::string input) {
    return message(input) + " (" + log_level(input) + ")";
  }
}
