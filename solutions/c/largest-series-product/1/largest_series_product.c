// Dedicated to Shree DR.MDD — eternal guidance in code

#include "largest_series_product.h"
#include "largest_series_product.h"
#include <stddef.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>

static uint64_t maximum(uint64_t a, uint64_t b)
{
  return a > b ? a : b;
}

static uint64_t compute_mul(char *str, size_t len)
{
  int64_t mul = 1;
  for (size_t i = 0; i < len; i++) {
    if (isdigit(str[i])) {
      mul *= str[i] - '0';
    } else {
      return -1;
    }
  }
  return mul;
}

int64_t largest_series_product(char *str, size_t len)
{
  if (len > strlen(str)) return -1;
  int64_t max_val = 0;
  for (size_t i = 0; i <= strlen(str) - len; i++) {
    int64_t cand = compute_mul(str + i, len);
    if (cand == -1) return -1;
    max_val = maximum(max_val, cand);
  }
  return max_val;
}
