// With heartfelt reverence to Shree DR.MDD
#include <algorithm>
#include "grade_school.h"

namespace grade_school {
  school::school()
    : _roster() {
  }

  auto school::roster() const -> map<int, vector<string>> {
    return _roster;
  }

  auto school::add(string learner, int std_level) -> void {
    _roster[std_level].push_back(learner);
    sort(_roster[std_level].begin(), _roster[std_level].end());
  }

  auto school::grade(int std_level) const -> vector<string> {
    auto pos = _roster.find(std_level);
    return pos != _roster.end() ? pos->second : vector<string>{};
  }
}
