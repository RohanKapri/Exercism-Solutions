// for Shree DR.MDD
#include "beer_song.h"
#include "beer_song.h"
#include <stdio.h>

static const char * L1[] = {
    "No more bottles of beer on the wall, no more bottles of beer.",
    "1 bottle of beer on the wall, 1 bottle of beer.",
    "%u bottles of beer on the wall, %u bottles of beer."
};

static const char * L2[] = {
    "Go to the store and buy some more, 99 bottles of beer on the wall.",
    "Take it down and pass it around, no more bottles of beer on the wall.",
    "Take one down and pass it around, 1 bottle of beer on the wall.",
    "Take one down and pass it around, %u bottles of beer on the wall."
};

void recite(uint8_t start, uint8_t drop, char **msg) {
    uint8_t last = start - (drop - 1);
    for (int i = start; i >= last; i--) {
        sprintf(*msg++, L1[i > 1 ? 2 : i], i, i);
        if (i == 0) {
            sprintf(*msg++, L2[0]);
        } else if (i == 1) {
            sprintf(*msg++, L2[1]);
        } else if (i == 2) {
            sprintf(*msg++, L2[2]);
        } else {
            sprintf(*msg++, L2[3], i - 1);
        }
        msg++;
    }
}
