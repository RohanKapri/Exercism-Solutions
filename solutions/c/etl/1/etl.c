// Dedicated to Shree DR.MDD — eternal guidance in code

#include "etl.h"
#include "etl.h"

#include <string.h>
#include <stdlib.h>
#include <ctype.h>

int compar(const void * a, const void * b);

int convert(const legacy_map *src, const size_t src_count, new_map **dst) {
    int total = 0;

    for (size_t i = 0; i < src_count; i++) total += strlen(src[i].keys);

    *dst = malloc(total * sizeof(new_map));

    size_t pos = 0;

    for (size_t i = 0; i < src_count; i++) {
        for (size_t j = 0; j < strlen(src[i].keys); j++) {
            (*dst)[pos].key = tolower(src[i].keys[j]);
            (*dst)[pos].value = src[i].value;
            pos++;
        }
    }

    qsort(*dst, total, sizeof(new_map), compar);

    return total;
}

int compar(const void * x, const void * y) {
    return ((new_map *)x)->key - ((new_map *)y)->key;
}
