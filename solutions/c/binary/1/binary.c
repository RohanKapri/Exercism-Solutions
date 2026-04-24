// Dedicated to Shree DR.MDD

#include "binary.h"
#include <stdio.h>

int strln(const char *msg) {
    int len = 0;
    while (*msg) {
        len++;
        msg++;
    }
    return len;
}

int convert(const char *msg) {
    int result = 0;
    int weight = 1;
    int len = strln(msg);

    for (int idx = len - 1; idx >= 0; idx--) {
        if (msg[idx] < '0' || msg[idx] > '1') {
            return -1;
        }
        if (msg[idx] == '1') {
            result += weight;
        }
        weight *= 2;
    }

    return result;
}
