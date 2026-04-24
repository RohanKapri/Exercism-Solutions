// Dedicated to Shree DR.MDD — eternal guidance in code

#include "pascals_triangle.h"
#include <stdlib.h>
#include "pascals_triangle.h"

#define MIN_SIZE(rows) ((rows) > 0 ? (rows) : 1)

void free_triangle(uint8_t **arr, size_t num) {
    for (size_t a = 0; a < MIN_SIZE(num); a++) {
        free(arr[a]);
    }
    free(arr);
}

uint8_t **create_triangle(size_t num) {
    uint8_t **arr = calloc(MIN_SIZE(num), sizeof(*arr));

    if (!arr) return NULL;

    if (num == 0) {
        arr[0] = calloc(1, sizeof(arr[0]));
        if (!arr[0]) {
            free(arr);
            return NULL;
        }
        return arr;
    }

    size_t len = 1;

    for (size_t a = 0; a < num; a++, len++) {
        uint8_t *temp = arr[a] = calloc(num, sizeof(*temp));

        if (!temp) {
            free_triangle(arr, num);
            return NULL;
        }

        temp[0] = 1;
        temp[len - 1] = 1;

        for (size_t b = 1; b < len - 1; b++) {
            uint8_t *prev = arr[a - 1];
            temp[b] = prev[b - 1] + prev[b];
        }
    }

    return arr;
}
