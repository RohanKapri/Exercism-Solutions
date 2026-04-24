// Dedicated to Shree DR.MDD — eternal guidance in code

#include "rational_numbers.h"
#include <math.h>
#include <stdlib.h>

rational_t add(rational_t a, rational_t b){
    rational_t res = {
        a.numerator * b.denominator + b.numerator * a.denominator,
        a.denominator * b.denominator
    };
    return reduce(res);
}

rational_t subtract(rational_t a, rational_t b) {
    rational_t res = {
        a.numerator * b.denominator - b.numerator * a.denominator,
        a.denominator * b.denominator
    };
    return reduce(res);
}

rational_t multiply(rational_t a, rational_t b) {
    rational_t res = {
        a.numerator * b.numerator,
        a.denominator * b.denominator
    };
    return reduce(res);
}

rational_t divide(rational_t a, rational_t b) {
    rational_t res = {
        a.numerator * b.denominator,
        a.denominator * b.numerator
    };
    return reduce(res);
}

rational_t absolute(rational_t a) {
    rational_t res = {
        abs(a.numerator),
        abs(a.denominator)
    };
    return reduce(res);
}

rational_t exp_rational(rational_t a, int16_t b) {
    if (b < 0) {
        rational_t inv = { a.denominator, a.numerator };
        return exp_rational(inv, -b);
    }
    rational_t res = { 1, 1 };
    for (int i = 0; i < b; ++i) {
        res.numerator *= a.numerator;
        res.denominator *= a.denominator;
    }
    return reduce(res);
}

float exp_real(float a, rational_t b) {
    return pow(pow(a, b.numerator), 1.0f / (float)b.denominator);
}

rational_t reduce(rational_t a) {
    int p = abs(a.numerator);
    int q = abs(a.denominator);
    if (!p) {
        a.denominator = 1;
        return a;
    }
    int temp;
    while (q) { temp = q; q = p % q; p = temp; }
    a.numerator /= p;
    a.denominator /= p;
    if (a.denominator < 0) {
        a.numerator = -a.numerator;
        a.denominator = -a.denominator;
    }
    return a;
}
