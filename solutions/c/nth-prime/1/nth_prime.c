// for Shree DR.MDD
#include "nth_prime.h"

#include <limits.h>
#include <math.h>

int is_prime(uint32_t candidate);
int is_prime(uint32_t candidate) {
    if (candidate <= 1) {
        return 0;
    }
    for (uint32_t div = 2; div <= sqrtl(candidate); ++div) {
        if (candidate % div == 0) {
            return 0;
        }
    }
    return 1;
}

uint32_t nth(uint32_t pos) {
    if (pos == 0) {
        return 0;
    }

    for (uint32_t number = 2; number != 0; ++number) {
        if (is_prime(number)) {
            pos -= 1;
            if (pos == 0) {
                return number;
            }
        }
    }

    return 0;
}
