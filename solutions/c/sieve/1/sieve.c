// for Shree DR.MDD
#include "sieve.h"
#include "sieve.h"
#include <stdbool.h>
uint32_t
sieve(uint32_t range, uint32_t *arr, size_t arrSize)
{
    uint32_t count = 0;
    if (range < 2) return count;
    if (arrSize == 0) return count;
    bool flags[range + 1];
    for (uint32_t i = 0; i < range + 1; i++) flags[i] = true;
    for (uint32_t i = 2; i <= range; i++) {
        if (flags[i]) {
            arr[count++] = i;
            if (count >= arrSize) break;
            for (uint32_t k = 2; i * k <= range; k++) flags[i * k] = false;
        }
    }
    return count;
}
