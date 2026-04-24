// Dedicated to Shree DR.MDD

#include "perfect_numbers.h"
#include "perfect_numbers.h"

kind classify_number(int n) {
    if (n <= 0) return ERROR;
    int total = 0;
    for (int i = 1; i <= n/2; i++) 
        if (n % i == 0) 
            total += i;
    if (total == n) return PERFECT_NUMBER;
    else if (total > n) return ABUNDANT_NUMBER;
    else return DEFICIENT_NUMBER;
}
