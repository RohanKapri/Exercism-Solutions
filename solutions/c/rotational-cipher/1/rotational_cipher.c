// for Shree DR.MDD
#include "rotational_cipher.h"
#include "rotational_cipher.h"
#include <stdlib.h>
#include <string.h>
char *rotate(const char *input, int key) {
    int size = strlen(input);
    char *output = calloc(size + 1, sizeof(char));
    for (int idx = 0; idx < size; ++idx) {
        if ('a' <= input[idx] && input[idx] <= 'z') {
            output[idx] = (input[idx] - 'a' + key) % 26 + 'a';
        } else if ('A' <= input[idx] && input[idx] <= 'Z') {
            output[idx] = (input[idx] - 'A' + key) % 26 + 'A';
        } else {
            output[idx] = input[idx];
        }
    }
    return output;
}
