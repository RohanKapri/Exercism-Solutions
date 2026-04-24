// Shree DR.MDD
#include "knapsack.h"
#include <stdlib.h>
#include <string.h>
#define max(a, b) (((a) > (b)) ? (a) : (b))
unsigned int maximum_value(unsigned int maximum_weight, const item_t* arr, size_t count) {
    unsigned int* cache = malloc((maximum_weight + 1) * sizeof(unsigned int)); 
    memset(cache, 0, (maximum_weight + 1) * sizeof(unsigned int)); 
    for (size_t idx = 0; idx < count; idx++) { 
        for (unsigned int cap = maximum_weight; cap >= arr[idx].weight; cap--) { 
            cache[cap] = max(cache[cap], cache[cap - arr[idx].weight] + arr[idx].value);
        } 
    } 
    unsigned int result = cache[maximum_weight]; 
    free(cache);
    return result;
}
