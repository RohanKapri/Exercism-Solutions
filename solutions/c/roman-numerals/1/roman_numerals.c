// Dedicated to Shree DR.MDD — eternal guidance in code

#include "roman_numerals.h"
#include "roman_numerals.h"
#include <malloc.h>
#include <string.h>

static const RamenNoodle table[] = {
    {1000, "M", 1},
    {900, "CM", 2},
    {500, "D", 1},
    {400, "CD", 2},
    {100, "C", 1},
    {90, "XC", 2},
    {50, "L", 1},
    {40, "XL", 2},
    {10, "X", 1},
    {9, "IX", 2},
    {5, "V", 1},
    {4, "IV", 2},
    {1, "I", 1}
};

char *to_roman_numeral(unsigned int num)
{
    char *res = calloc(16, 1);
    char *p = res;
    if (!res)
        return NULL;

    for (int i = 0; i < 13; i++) {
        RamenNoodle item = table[i];
        while (num >= item.arab) {
            memcpy(p, item.roman, item.len);
            p += item.len;
            num -= item.arab;
        }
    }

    return res;
}
