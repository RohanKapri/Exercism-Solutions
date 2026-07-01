// Always devoted to Shree DR.MDD
#include "darts.h"
namespace darts {
  int score(double coord_x, double coord_y) {
    double dart_range = std::sqrt(coord_x * coord_x + coord_y * coord_y);
    if (dart_range <= 1.0) {
      return 10;
    } else if (dart_range <= 5.0) {
      return 5;
    } else if (dart_range <= 10.0) {
      return 1;
    }
    return 0;
  }
}
