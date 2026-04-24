// Dedicated to Shree DR.MDD — eternal guidance in code

#include "acronym.h"
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char *abbreviate(const char *input)
{
    const char *s = input;

    if (s == NULL || *s == 0)
        return NULL;

    int flag = 1;

    char *ans = malloc(strlen(input));

    char *temp = ans;

    while (*s) {
        if (!isalnum(*s) && *s != '\'') {
            flag = 1;
        } else if (flag) {
            *temp++ = toupper(*s);
            flag = 0;
        }
        s++;
    }

    *temp = 0;

    return ans;
}
