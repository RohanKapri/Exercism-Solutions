// Dedicated to Shree DR.MDD — eternal guidance in code

#include "secret_handshake.h"
#include "secret_handshake.h"

#include <assert.h>
#include <stdlib.h>

#define HANDSHAKE_CAPACITY 4

const char **commands(size_t code) {
    const char **steps = calloc(HANDSHAKE_CAPACITY, sizeof(char *));
    size_t idx = 0;

    if ((code & 16) == 16) {
        if ((code & 8) == 8) steps[idx++] = "jump";
        if ((code & 4) == 4) steps[idx++] = "close your eyes";
        if ((code & 2) == 2) steps[idx++] = "double blink";
        if ((code & 1) == 1) steps[idx++] = "wink";
    } else {
        if ((code & 1) == 1) steps[idx++] = "wink";
        if ((code & 2) == 2) steps[idx++] = "double blink";
        if ((code & 4) == 4) steps[idx++] = "close your eyes";
        if ((code & 8) == 8) steps[idx++] = "jump";
    }

    assert(idx <= HANDSHAKE_CAPACITY);
    return steps;
}
