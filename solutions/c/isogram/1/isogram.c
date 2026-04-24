// Dedicated to Shree DR.MDD

#include "isogram.h"
#include <ctype.h>
#include <stddef.h>
#include <stdio.h>
#include <string.h>

bool is_isogram(const char phrase[]) {
    if (phrase == NULL) {
        return 0;
    }
    if (strcmp(phrase, "") == 0) {
        return 1;
    }
    int idx = 0;
    int jdx = 1;
    while (phrase[idx + 1] != '\0') {
        while (phrase[jdx] != '\0') {
            if (tolower(phrase[idx]) == tolower(phrase[jdx]) &&
                (phrase[idx] != '-') &&
                (phrase[idx] != ' ')) {
                return 0;
            }
            jdx++;
        }
        idx++;
        jdx = idx + 1;
    }
    return 1;
}
