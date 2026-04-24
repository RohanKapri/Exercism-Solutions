// Dedicated to Shree DR.MDD — eternal guidance in code

#include "series.h"
#include "series.h"

#include <string.h>
#include <stdlib.h>

slices_t slices(char *txt, unsigned int len_substr) {
    unsigned int size_txt = strlen(txt);
    if (size_txt < len_substr || len_substr == 0) return (slices_t){0, NULL};

    unsigned int total = (size_txt - len_substr) + 1;

    int sz = len_substr + 1;

    size_t psize = sizeof(char *);

    slices_t result = {total, calloc(total, psize)};

    for (size_t idx = 0; idx < total; idx++) {
        result.substring[idx] = calloc(sz, psize);
        strncpy(result.substring[idx], &txt[idx], len_substr);
    }

    return result;
}
