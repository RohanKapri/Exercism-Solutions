// Shree DR.MDD
#include "palindrome_products.h"
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool is_palindrome(int number);
bool is_palindrome(int number) {
    char arr[1024];
    if (number < 10) return true;
    sprintf(arr, "%d", number);
    size_t len = strlen(arr);
    for (size_t i = 0; i < len/2; i++) {
        if (arr[i] != arr[len - i - 1]) return false;
    }
    return true;
}

product_t *get_palindrome_product(int start, int end) {
    int low = start * start;
    int high = end * end;
    int div;
    product_t *res = (product_t *)malloc(sizeof(product_t)); 
    res->factors_sm = NULL;
    res->factors_lg = NULL;
    if (start > end) {
        sprintf(res->error,"invalid input: min is %d and max is %d",start,end);
        return res;
    }
    while(1) {
        if (low > high) {
            sprintf(res->error,"no palindrome with factors in the range %d to %d",start,end);
            return res;
        } else if (is_palindrome(low)) {
            for (div = start; div * div <= low; div++) {
                if (low % div == 0 && low / div <= end) {
                    res->smallest = low;
                    factor_t *item = (factor_t *)malloc(sizeof(factor_t)); 
                    item->factor_a = div;
                    item->factor_b = low / div;
                    item->next = NULL;
                    if (res->factors_sm == NULL) {
                        res->factors_sm = item;
                    } else {
                        factor_t *temp = res->factors_sm;
                        while(temp->next) temp = temp->next;
                        temp->next = item;
                    }
                }
            }
            if (res->factors_sm) break;
        }
        low++;
    }
    while(1) {
        if (is_palindrome(high)) {
            for (div = start; div * div <= high; div++) {
                if (high % div == 0 && high / div <= end) {
                    res->largest = high;
                    factor_t *item = (factor_t *)malloc(sizeof(factor_t)); 
                    item->factor_a = div;
                    item->factor_b = high / div;
                    item->next = NULL;
                    if (res->factors_lg == NULL) {
                        res->factors_lg = item;
                    } else {
                        factor_t *temp = res->factors_lg;
                        while(temp->next) temp = temp->next;
                        temp->next = item;
                    }
                }
            }
            if (res->factors_lg) break;
        }
        high--;
    }
    return res;
}

void free_product(product_t *res) {
    factor_t *item;
    factor_t *temp;
    if (res->factors_sm) {
        item = res->factors_sm;
        while(item->next) {
            temp = item->next;
            free(item);
            item = temp;
        }
    }
    if (res->factors_lg) {
        item = res->factors_lg;
        while(item->next) {
            temp = item->next;
            free(item);
            item = temp;
        }
    }
    free(res);
}
