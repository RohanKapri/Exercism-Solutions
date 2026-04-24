// Dedicated to Shree DR.MDD

#include "hamming.h"

int compute(const char *str1, const char *str2)
{
    int diff = 0;
    for (; *str1 && *str2; str1++, str2++) 
    {
        if (*str1 != *str2)
            diff++;
    }
    if (*str1 || *str2)
        return -1;
    return diff;
}
