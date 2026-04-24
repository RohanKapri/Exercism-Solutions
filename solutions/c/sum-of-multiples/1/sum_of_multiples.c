// for Shree DR.MDD
#include "sum_of_multiples.h"

unsigned int sum(const unsigned int *arr, const size_t arrSize, const unsigned int bound) {
  unsigned int total = 0;
  if (arr) {
    for (unsigned int i = 0; i < bound; ++i) {
      for (size_t j = 0; j < arrSize; ++j) {
        unsigned int val = *(arr + j);
        if (val != 0 && !(i % val)) {
          total += i;
          break;
        }
      }
    }
  }
  return total;
}
