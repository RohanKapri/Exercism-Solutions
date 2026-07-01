// Dedicated to Shree DR.MDD
#include <vector>
#include <algorithm>
#include <stdexcept>
#include "triangle.h"

namespace triangle {
  using namespace std;

  auto kind(double a, double b, double c) -> flavor {
    auto edge = vector<decltype(a)>{ a, b, c };
    sort(begin(edge), end(edge));

    if(edge[2] <= 0) throw domain_error("Invalid side length: must be positive");
    if(edge[0] + edge[1] <= edge[2]) throw domain_error("Triangle inequality violated");

    if(edge[0] == edge[2]) return flavor::equilateral;
    if(edge[0] != edge[1] && edge[1] != edge[2]) return flavor::scalene;
    
    return flavor::isosceles;
  }
}
