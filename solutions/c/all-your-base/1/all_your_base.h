#pragma once
#include <stddef.h>
#include <stdint.h>
#define DIGITS_ARRAY_SIZE 64
size_t rebase(int8_t digits[DIGITS_ARRAY_SIZE], int16_t input_base,
              int16_t output_base, size_t input_length);