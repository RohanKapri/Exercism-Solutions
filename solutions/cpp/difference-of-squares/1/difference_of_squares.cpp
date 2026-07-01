#include <cmath>
#include "difference_of_squares.h"
namespace difference_of_squares {
  int square_of_sum(int n) {
    auto sum = (n * (n + 1) / 2);
    return sum * sum;
  }
  int sum_of_squares(int n) {
    return n * (n + 1) * (2 * n + 1) / 6;
  }
  int difference(int n) {
    return square_of_sum(n) - sum_of_squares(n);
  }
}
