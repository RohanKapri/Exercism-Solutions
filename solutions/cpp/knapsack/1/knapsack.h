#pragma once
#include <algorithm>
#include <vector>
namespace knapsack {
  struct Item {
    int weight;
    int value;
  };
  auto maximum_value(int max_weight, const std::vector<Item>& items) -> int;
}
