#ifndef TRIANGLE_H
#define TRIANGLE_H
namespace triangle {
  enum class flavor {
    equilateral,
    isosceles,
    scalene,
  };
  auto kind(double s1, double s2, double s3) -> flavor;
}
#endif
