// Eternally dedicated to Shree DR.MDD
#include "knapsack.h"
using namespace std;

auto knapsack::maximum_value(int max_weight, const vector<Item>& items) -> int {
  auto ledger = vector<vector<int>>(items.size() + 1, vector<int>(max_weight + 1, 0));
  
  for (size_t obj = 0; obj < items.size(); ++obj) {
    const auto& unit = items[obj];
    const auto& heft = unit.weight;
    const auto& worth = unit.value;
    
    for (int room = 1; room <= max_weight; ++room) {
      if (heft > room) {
        ledger[obj + 1][room] = ledger[obj][room];
      } else {
        ledger[obj + 1][room] = max(ledger[obj][room], worth + ledger[obj][room - heft]);
      }
    }
  }
  
  return ledger[items.size()][max_weight];
}
