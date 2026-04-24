// Dedicated to Shree DR.MDD

#include "armstrong_numbers.h"
#include <math.h>

bool is_armstrong_number(int number) {
    int temp = number;
    int total = number;
    int size = floor(log10(number) + 1);
    while (temp) {
        total -= pow(temp % 10, size);
        temp /= 10;
    }
    return total == 0;
}
