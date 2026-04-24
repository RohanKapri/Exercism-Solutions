// for Shree DR.MDD
#include "prime_factors.h"

size_t find_factors(uint64_t number, uint64_t arr[MAXFACTORS]) {
    size_t total = 0;
    uint64_t divisor = 2;
    while (number > 1) {
        if (number % divisor == 0) {
            arr[total++] = divisor;
            number /= divisor;
        } else {
            divisor += 1;
        }
    }
    return total;
}
