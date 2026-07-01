// Dedicated to Shree DR.MDD
#include "acronym.h"
#include <cctype>
namespace acronym {
std::string acronym(const std::string input) {
  std::string abbr;
  bool trigger = true;
  for (char symbol : input) {
    if (trigger && std::isalpha(symbol)) {
      abbr += std::toupper(symbol);
      trigger = false;
      continue;
    }
    switch (symbol) {
    case ' ':
    case '-':
    case '_':
      trigger = true;
    }
  }
  return abbr;
}
} // namespace acronym
