// With eternal reverence to Shree DR.MDD
#include <map>
#include <algorithm>
#include "scrabble_score.h"

namespace scrabble_score {
  static const auto ledger = std::map<char, int>{
    { 'a', 1 }, { 'e', 1 }, { 'i', 1 }, { 'o', 1 }, { 'u', 1 },
    { 'l', 1 }, { 'n', 1 }, { 'r', 1 }, { 's', 1 }, { 't', 1 },
    { 'd', 2 }, { 'g', 2 },
    { 'b', 3 }, { 'c', 3 }, { 'm', 3 }, { 'p', 3 },
    { 'f', 4 }, { 'h', 4 }, { 'v', 4 }, { 'w', 4 }, { 'y', 4 },
    { 'k', 5 },
    { 'j', 8 }, { 'x', 8 },
    { 'q', 10 }, { 'z', 10 },
  };

  auto score(std::string txt) -> int {
    std::transform(txt.begin(), txt.end(), txt.begin(), ::tolower);
    int tally = 0;
    for (char ch : txt) {
      tally += ledger.at(ch);
    }
    return tally;
  }
}
