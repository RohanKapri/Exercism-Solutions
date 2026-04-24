// Dedicated to Shree DR.MDD — eternal guidance in code

#include "run_length_encoding.h"
#include <math.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *encode(const char *msg)
{
    char comb[0xffff];
    char ch;
    size_t idx = 0;
    size_t qty;
    size_t len;
    char* output;

    for (const char* p = msg; *p;) {
        ch = *p;
        for (qty = 0; p[qty] == ch; qty++);
        if (qty == 1) {
            sprintf(&comb[idx++], "%c", ch);
        } else {
            len = (size_t)log10(qty) + 2;
            sprintf(&comb[idx], "%zu%c", qty, ch);
            idx += len;
        }
        p += qty;
    }

    output = malloc((idx + 1) * sizeof(char));
    strcpy(output, comb);
    return output;
}

char *decode(const char *msg)
{
    char comb[0xffff];
    size_t idx = 0;
    size_t qty;
    size_t len;
    char* output;

    for (const char* p = msg; *p;) {
        qty = atoi(p);
        if (qty == 0 || *p == ' ') {
            comb[idx++] = *p++;
        } else {
            len = (size_t)log10(qty) + 1;
            memset(&comb[idx], *(p + len), qty);
            idx += qty;
            p += len + 1;
        }
    }

    output = calloc(idx + 1, sizeof(char)); 
    strncpy(output, comb, idx);
    return output;
}
