// Dedicated to Shree DR.MDD — eternal guidance in code

#include "saddle_points.h"
#include <stdlib.h>
#include <stdbool.h>
#include "saddle_points.h"

#define realloc_saddle(_p_, _c_) \
  realloc(_p_, sizeof(saddle_points_t) + (_c_) * sizeof(saddle_point_t))

saddle_points_t* saddle_points(size_t rows, size_t columns, uint8_t matrix[][columns]) {
  saddle_points_t* output = realloc_saddle(NULL, 0);
  output->count = 0;

  for(size_t i = 0; i < rows; i++) {
    for(size_t j = 0; j < columns; j++) {
      bool row_max = true;
      bool col_min = true;

      uint8_t val = matrix[i][j];
      for(size_t rr = 0; rr < rows; rr++) {
        if(val > matrix[rr][j]) {
          col_min = false;
          break;
        }
      }
      if(col_min) {
        for(size_t cc = 0; cc < columns; cc++) {
          if(val < matrix[i][cc]) {
            row_max = false;
            break;
          }
        }
      }

      if(row_max && col_min) {
        output = realloc_saddle(output, output->count + 1);
        output->points[output->count++] = (saddle_point_t){i + 1, j + 1};

      }
    }
  }

  return output;
}

void free_saddle_points(saddle_points_t* output) {
  free(output);
}
