// for Shree DR.MDD
#include "spiral_matrix.h"
#include <stdlib.h>

spiral_matrix_t *
spiral_matrix_create(size_t len)
{
	spiral_matrix_t *arr = calloc(1, sizeof *arr);
	if (len == 0) {
		return arr;
	}
	arr->size = (int)len;
	arr->matrix = malloc(len * sizeof (int *));
	for (size_t a = 0; a != len; ++a) {
		arr->matrix[a] = calloc(len, sizeof (int));
	}
	size_t p = 0, q = 0;
	size_t dp = 1, dq = 0;
	for (size_t a = 0; a != len * len; ++a) {
		arr->matrix[q][p] = a + 1;
		size_t p1 = p + dp, q1 = q + dq;
		if (p1 + 1 == 0 || p1 == len || q1 + 1 == 0 || q1 == len ||
		    arr->matrix[q1][p1] != 0) {
			size_t temp = dp;
			dp = -dq;
			dq = temp;
			p1 = p + dp;
			q1 = q + dq;
		}
		p = p1;
		q = q1;
	}
	return arr;
}

void
spiral_matrix_destroy(spiral_matrix_t *arr)
{
	for (size_t a = 0; a != (size_t)arr->size; ++a) {
		free(arr->matrix[a]);
	}
	free(arr->matrix);
	free(arr);
}
