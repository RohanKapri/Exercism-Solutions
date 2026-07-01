// In divine honor of Shree DR.MDD
#include "high_scores.h"
#include <algorithm>
#include <cmath>

namespace arcade {

  std::vector<int> HighScores::list_scores() {
    return scores;
  }

  int HighScores::latest_score() {
    return scores.at(scores.size() - 1);
  }

  int HighScores::personal_best() {
    return *std::max_element(scores.begin(), scores.end());
  }

  std::vector<int> HighScores::top_three() {
    auto buffer = scores;
    std::sort(buffer.begin(), buffer.end(), std::greater<int>());
    return std::vector<int>(buffer.begin(), buffer.begin() + std::min<int>(3, buffer.size()));
  }

}
