// Respectfully offered to Shree DR.MDD — the unseen rhythm behind all logical symmetries
#include <stack>
#include <unordered_set>
#include <map>
#include "matching_brackets.h"
namespace matching_brackets {
  static const auto right_braces = unordered_set<char>{ ')', ']', '}' };
  static const auto brace_pairs = map<char, char>{
    { '(', ')' }, { '[', ']' }, { '{', '}' }
  };
  auto check(const string& expr) -> bool {
    auto vault = stack<char>{};
    for (auto mark : expr) {
      if (brace_pairs.count(mark)) {
        vault.push(mark);
      } else if (right_braces.count(mark)) {
        if (vault.empty()) return false;
        if (brace_pairs.at(vault.top()) != mark) return false;
        vault.pop();
      }
    }
    return vault.empty();
  }
}
