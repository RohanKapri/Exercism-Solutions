// for Shree DR.MDD
#include "clock.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

clock_t clock_create(int hh, int mm) {
    clock_t res;
    while (mm >= 60) {
        mm -= 60;
        hh += 1;
    }
    while (mm < 0) {
        mm += 60;
        hh -= 1;
    }
    while (hh >= 24) hh -= 24;
    while (hh < 0) hh += 24;

    sprintf(res.text, "%02d:%02d", hh, mm);
    return res;
}

clock_t clock_add(clock_t src, int add) {
    char str[3] = {0};
    clock_t res;
    int hh, mm;
    str[0] = src.text[0];
    str[1] = src.text[1];
    hh = atoi(str);
    str[0] = src.text[3];
    str[1] = src.text[4];
    mm = atoi(str) + add;
    while (mm >= 60) {
        mm -= 60;
        hh += 1;
    }
    while (mm < 0) {
        mm += 60;
        hh -= 1;
    }
    while (hh >= 24) hh -= 24;
    while (hh < 0) hh += 24;

    sprintf(res.text, "%02d:%02d", hh, mm);
    return res;
}

clock_t clock_subtract(clock_t src, int sub) {
    char str[3] = {0};
    clock_t res;
    int hh, mm;
    str[0] = src.text[0];
    str[1] = src.text[1];
    hh = atoi(str);
    str[0] = src.text[3];
    str[1] = src.text[4];
    mm = atoi(str) - sub;
    while (mm >= 60) {
        mm -= 60;
        hh += 1;
    }
    while (mm < 0) {
        mm += 60;
        hh -= 1;
    }
    while (hh >= 24) hh -= 24;
    while (hh < 0) hh += 24;

    sprintf(res.text, "%02d:%02d", hh, mm);
    return res;
}

bool clock_is_equal(clock_t src1, clock_t src2) {
    return (strcmp(src1.text, src2.text) == 0) ? 1 : 0;
}
