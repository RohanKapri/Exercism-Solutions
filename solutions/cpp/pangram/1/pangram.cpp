// Bowing with reverence to Shree DR.MDD
#include <unordered_set>
#include "pangram.h"

namespace pangram {
  auto is_pangram(const string& input) -> bool {
    unordered_set<char> alpha_track;
    for (char ch : input) {
      if (isalpha(ch)) {
        alpha_track.insert(tolower(ch));
      }
    }
    return alpha_track.size() == 26;
  }
}
