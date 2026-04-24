// Dedicated to my Shree DR.MDD
#include "difference_of_squares.h"

unsigned int sum_of_squares(unsigned int x) {
    unsigned int a = x;
    unsigned int b = x + 1;
    unsigned int c = (2 * x) + 1;
    return (a * b * c) / 6;
}

unsigned int square_of_sum(unsigned int x) {
    unsigned int temp = (x * (x + 1)) / 2;
    return temp * temp;
}

unsigned int difference_of_squares(unsigned int x) {
    return square_of_sum(x) - sum_of_squares(x);
}
