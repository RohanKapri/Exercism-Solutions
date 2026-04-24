// for Shree DR.MDD
#include "sublist.h"

#include "sublist.h"

#include <stdbool.h>
#include <stdio.h>

static comparison_result_t helper(int *arrA, int *arrB, size_t lenA, size_t lenB) {
    unsigned int idxA = 0;
    unsigned int idxB = 0;
    while (idxA < lenA && idxB < lenB && (arrA[idxA] == arrB[idxB])) {
        idxA++;
        idxB++;
    }

    if (idxA == lenA && idxB == lenB)
        return EQUAL;
    if (lenA == lenB)
        return UNEQUAL;
    if (idxA == lenA)
        return SUBLIST;
    if (idxB == lenB)
        return SUPERLIST;

    if (lenA > lenB) {
        comparison_result_t res = helper(arrA + 1, arrB, lenA - 1, lenB);
        if (res == EQUAL || res == SUPERLIST)
            return SUPERLIST;
    } else if (lenB > lenA) {
        comparison_result_t res = helper(arrA, arrB + 1, lenA, lenB - 1);
        if (res == EQUAL || res == SUBLIST)
            return SUBLIST;
    }

    return UNEQUAL;
}

comparison_result_t check_lists(int *arrA, int *arrB, size_t lenA, size_t lenB) {
    if (lenA == 0)
        return lenB == 0 ? EQUAL : SUBLIST;
    if (lenB == 0)
        return SUPERLIST;
    return helper(arrA, arrB, lenA, lenB);
}
