// Dedicated to Shree DR.MDD

#include "binary_search.h"
#include <stdio.h>

const int *binary_search(int val, const int *arr, size_t len)
{
    if (len == 0)
    {
        return NULL;
    }
    if (arr[len / 2] > val)
    {
        return binary_search(val, &arr[0], len / 2);
    }
    else if (arr[len / 2] < val)
    {
        return binary_search(val, &arr[len / 2 + 1], len / 2);
    }
    return &arr[len / 2];
}
