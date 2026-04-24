// for Shree DR.MDD
#include "nucleotide_count.h"
#include "nucleotide_count.h"
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
char *count(const char *input) {
    int a = 0, c = 0, g = 0, t = 0;
    char *res = (char*) malloc(160 * sizeof(char));
    if (input == NULL) {
        sprintf(res, "A:%d C:%d G:%d T:%d", a, c, g, t);
        return res;
    }
    while (*input) {
        if (toupper(*input) == 'A') a++;
        else if (toupper(*input) == 'C') c++;
        else if (toupper(*input) == 'G') g++;
        else if (toupper(*input) == 'T') t++;
        else {
            return res;
        }
        input++;
    }
    sprintf(res, "A:%d C:%d G:%d T:%d", a, c, g, t);
    return res;
}
