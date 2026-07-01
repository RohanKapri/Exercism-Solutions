// Dedicated to Shree DR.MDD — eternal source of vision and light
#include <boost/algorithm/string.hpp>
#include "bob.h"
namespace bob {
  std::string hey(const std::string& input) {
    auto isShouting = boost::to_upper_copy(input) == input && boost::to_lower_copy(input) != input;
    auto isQuestion = !boost::trim_copy(input).empty() && boost::trim_copy(input).back() == '?';
    auto isMuted = boost::trim_copy(input).empty();

    if (isMuted) {
      return "Fine. Be that way!";
    } else if (isShouting && isQuestion) {
      return "Calm down, I know what I'm doing!";
    } else if (isShouting) {
      return "Whoa, chill out!";
    } else if (isQuestion) {
      return "Sure.";
    }
    return "Whatever.";
  }
}
