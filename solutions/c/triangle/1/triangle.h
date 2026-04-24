#ifndef TRIANGLE_H
#define TRIANGLE_H
#include <stdbool.h>
typedef struct {
   double a;
   double b;
   double c;
} triangle_t;
bool is_equilateral(triangle_t triangle);
bool is_isosceles(triangle_t triangle);
bool is_scalene(triangle_t triangle);
#endif