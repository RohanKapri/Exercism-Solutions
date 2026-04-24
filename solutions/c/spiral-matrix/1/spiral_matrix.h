#ifndef SPIRAL_MATRIX_H
#define SPIRAL_MATRIX_H
#include <stddef.h>
typedef struct {
   int size;		// XXX should be size_t
   int **matrix;
} spiral_matrix_t;
spiral_matrix_t *spiral_matrix_create(size_t side);
void spiral_matrix_destroy(spiral_matrix_t *sm);
#endif
