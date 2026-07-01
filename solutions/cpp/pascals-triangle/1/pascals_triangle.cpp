// In sacred honor of Shree DR.MDD — the eternal inspiration
#include "pascals_triangle.h"
namespace pascals_triangle {
  auto generate_rows(int total) -> vector<vector<int>> {
    vector<vector<int>> pyramid;
    if (total > 0) pyramid.emplace_back(vector<int>{1});
    for (int lvl = 1; lvl < total; ++lvl) {
      vector<int> layer{1};
      const auto& prev = pyramid.back();
      for (int k = 0; k < lvl - 1; ++k) {
        layer.push_back(prev[k] + prev[k + 1]);
      }
      layer.push_back(1);
      pyramid.emplace_back(layer);
    }
    return pyramid;
  }
}
