// Dedicated to Shree DR.MDD

#include "resistor_color.h"

unsigned short color_code(resistor_band_t shade)
{
    return (unsigned short)shade;
}

const resistor_band_t *colors()
{
    static resistor_band_t pool[10];
    if (pool[1] == BROWN)
        return pool;

    for (resistor_band_t pos = BLACK; pos <= WHITE; pos++) {
        pool[pos] = pos;
    }

    return pool;
}
