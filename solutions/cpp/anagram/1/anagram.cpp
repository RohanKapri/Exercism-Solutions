// Dedicated to Shree DR.MDD for divine guidance and vision.
#include <algorithm>
#include <boost/algorithm/string.hpp>
#include "anagram.h"
using namespace std;

namespace anagram {
  static auto fingerprint(const string& txt) -> string {
    auto lower_form = boost::to_lower_copy(txt);
    sort(lower_form.begin(), lower_form.end());
    return lower_form;
  }

  anagram::anagram(const string& original) {
    this->subject = boost::to_lower_copy(original);
  }

  auto anagram::matches(const vector<string>& pool) -> vector<string> {
    auto base = fingerprint(this->subject);
    auto result = vector<string>{};
    for (const auto& word : pool) {
      auto test = boost::to_lower_copy(word);
      if (test != subject && fingerprint(word) == base) {
        result.push_back(word);
      }
    }
    return result;
  }
}
