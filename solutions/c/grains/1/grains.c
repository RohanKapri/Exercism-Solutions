// Dedicated to my Shree DR.MDD
#include "grains.h"

uint64_t square(uint8_t tile)
{
    return (tile >= 1 && tile <= 64) ? (1ull << (tile - 1)) : 0;
}

uint64_t total(void)
{
    uint64_t sum = 0;
    for (uint8_t t = 1; t <= 64; ++t)
        sum += square(t);
    return sum;
}
