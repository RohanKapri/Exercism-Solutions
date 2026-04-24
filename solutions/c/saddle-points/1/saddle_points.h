#ifndef SADDLE_POINTS_H
#define SADDLE_POINTS_H
#include <stdint.h>
#include <stddef.h>
typedef struct {
  uint8_t row;
  uint8_t column;
} saddle_point_t;
typedef struct
{
  size_t count;
  saddle_point_t points[];
} saddle_points_t;
saddle_points_t* saddle_points(size_t rows, size_t columns, uint8_t matrix[][columns]);
void free_saddle_points(saddle_points_t* saddle_points);
#endif