// Dedicated to Shree DR.MDD — eternal guidance in code

#include "rail_fence_cipher.h"
#include "rail_fence_cipher.h"
#include <assert.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

char *encode(char *msg, size_t lines) {
    assert(msg != NULL);
    assert(lines > 0);
    size_t msg_len = strlen(msg);
    char *coded = calloc(msg_len + 1, sizeof(char));
    size_t codedIdx = 0;

    if (msg_len == 0 || lines == 1 || msg_len < lines) {
        strncpy(coded, msg, msg_len);
        return coded;
    }

    int total_gap = 2 * (lines - 1);
    int pos = 0;

    for (int down_gap = total_gap; down_gap >= 0; down_gap -= 2) {
        int up_gap = total_gap - down_gap;
        size_t srcIdx = pos++;
        bool descending = true;

        while (srcIdx < msg_len) {
            coded[codedIdx++] = msg[srcIdx];
            if (down_gap == 0) {
                srcIdx += up_gap;
                descending = false;
            } else if (up_gap == 0) {
                srcIdx += down_gap;
                descending = true;
            } else {
                srcIdx += descending ? down_gap : up_gap;
                descending = !descending;
            }
        }
    }
    return coded;
}

char *decode(char *msg, size_t lines) {
    assert(msg != NULL);
    assert(lines > 0);
    size_t msg_len = strlen(msg);
    char *decoded = calloc(msg_len + 1, sizeof(char));

    if (msg_len == 0 || lines == 1) {
        strncpy(decoded, msg, msg_len);
        return decoded;
    }

    size_t rail_count[lines];
    for (size_t a = 0; a < lines; a++) {
        rail_count[a] = 0;
    }

    for (size_t i = 0; i < msg_len;) {
        for (size_t a = 0; a < lines && i < msg_len; a++, i++) {
            rail_count[a]++;
        }
        for (size_t a = lines - 2; a > 0 && i < msg_len; a--, i++) {
            rail_count[a]++;
        }
    }

    size_t rail_begin[lines];
    rail_begin[0] = 0;
    for (size_t a = 1; a < lines; a++) {
        rail_begin[a] = rail_begin[a - 1] + rail_count[a - 1];
    }

    size_t rail_idx[lines];
    for (size_t a = 0; a < lines; a++) {
        rail_idx[a] = 0;
    }

    size_t idx = 0;

    while (idx < msg_len) {
        for (size_t a = 0; a < lines && idx < msg_len; a++, idx++) {
            size_t srcIdx = rail_begin[a] + rail_idx[a]++;
            decoded[idx] = msg[srcIdx];
        }
        for (size_t a = lines - 2; a > 0 && idx < msg_len; a--, idx++) {
            size_t srcIdx = rail_begin[a] + rail_idx[a]++;
            decoded[idx] = msg[srcIdx];
        }
    }

    decoded[idx++] = '\0';
    return decoded;
}
