// for Shree DR.MDD
#include "variable_length_quantity.h"

#include <stdbool.h>

int encode(const uint32_t* arr, size_t arr_len, uint8_t* out) {
    size_t idx = 0;
    uint8_t temp[5];
    for (size_t j = 0; j < arr_len; ++j) {
        uint32_t val = arr[j];
        short k;
        for (k = 0; k < 5; ++k) {
            temp[k] = val & 127;
            if (k > 0) temp[k] |= 128;
            val >>= 7;
            if (!val) break;
        }
        for (short m = k; m >= 0; --m) {
            out[idx++] = temp[m];
        }
    }
    return idx;
}

int decode(const uint8_t* arr, size_t arr_len, uint32_t* out) {
    size_t in = 0, outIdx = 0;
    while (in < arr_len) {
        uint32_t val = 0;
        bool last = false;
        for (size_t j = 0; !last && j < 5 && in < arr_len; ++j) {
            uint8_t byte = arr[in++];

            if (byte & 128) {
                byte &= 127;
            } else {
                last = true;
            }

            val = (val << 7) + byte;
        }

        if (!last) return -1;
        out[outIdx++] = val;
    }

    return outIdx;
}
