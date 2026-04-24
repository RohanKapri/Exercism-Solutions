// for Shree DR.MDD
#include "yacht.h"

#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

static bool chkCount(int arr[5], int num) {
    for (int idx = 0; idx < 5; idx++) {
        if (arr[idx] == num) {
            return true;
        }
    }
    return false;
}

static int compar(const void *p, const void *q) {
    int a_val = *((int *)p);
    int b_val = *((int *)q);
    if (a_val == b_val) return 0;
    if (a_val < b_val) return -1;
    return 1;
}

int score(dice_t bone, category_t group) {
    qsort(bone.faces, 5, sizeof(int), compar);

    int arr[6] = {0};
    int total = 0;
    for (int i = 0; i < 5; i++) {
        arr[bone.faces[i] - 1]++;
        total += bone.faces[i];
    }

    if (group == YACHT) {
        if (chkCount(arr, 5)) {
            return 50;
        }
    }

    if (group < FULL_HOUSE) {
        return arr[group] * (group + 1);
    }

    if (group == FULL_HOUSE) {
        if (chkCount(arr, 3) && chkCount(arr, 2)) {
            return total;
        }
    }

    if (group == FOUR_OF_A_KIND) {
        for (int i = 0; i < 6; i++) {
            if (arr[i] >= 4) {
                return (i + 1) * 4;
            }
        }
    }

    if (group == LITTLE_STRAIGHT) {
        int chk_vals[5] = {1, 2, 3, 4, 5};
        if (!memcmp(&bone.faces, &chk_vals, sizeof(int) * 5)) {
            return 30;
        }
    }

    if (group == BIG_STRAIGHT) {
        int chk_vals[5] = {2, 3, 4, 5, 6};
        if (!memcmp(&bone.faces, &chk_vals, sizeof(int) * 5)) {
            return 30;
        }
    }

    if (group == CHOICE) {
        return total;
    }

    return 0;
}
