#pragma once
#include <vector>
namespace sublist {
  enum class List_comparison {
    equal,
    sublist,
    superlist,
    unequal
  };
  typedef std::vector<int> List;
  auto sublist(const List& a, const List& b) -> List_comparison;
}
