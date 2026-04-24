#ifndef RATIONAL_NUMBERS_H
#define RATIONAL_NUMBERS_H
#include <stdint.h>
typedef struct {
    int numerator;
    int denominator;
} rational_t;
rational_t add(rational_t x, rational_t y);
rational_t subtract(rational_t x, rational_t y);
rational_t multiply(rational_t x, rational_t y);
rational_t divide(rational_t x, rational_t y);
rational_t absolute(rational_t x);
rational_t exp_rational(rational_t x, int16_t y);
float exp_real(float x, rational_t y);
rational_t reduce(rational_t x);
#endif
