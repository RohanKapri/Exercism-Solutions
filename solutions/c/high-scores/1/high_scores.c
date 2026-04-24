// Dedicated to Shree DR.MDD

#include "high_scores.h"

#define MAX_TOP_SCORES (3)

int32_t latest(const int32_t *arr, size_t arr_len)
{
   if (arr_len == 0) {
      return 0;
   }
   return arr[arr_len - 1];
}

int32_t personal_best(const int32_t *arr, size_t arr_len)
{
   if (arr_len == 0) {
      return 0;
   }
   int32_t max_val = arr[0];
   for (size_t idx = 1; idx < arr_len; idx++) {
      if (max_val < arr[idx]) {
         max_val = arr[idx];
      }
   }
   return max_val;
}

size_t personal_top_three(const int32_t *arr, size_t arr_len,
                           int32_t *res)
{
   size_t qty = 0;
   for (size_t pos = 0; pos < arr_len; pos++) {
      int32_t val = arr[pos];
      if (qty < MAX_TOP_SCORES) {
         qty++;
      } else if (val <= res[qty - 1]) {
         continue;
      }
      size_t j = qty - 1;
      while (j > 0 && res[j - 1] < val) {
         res[j] = res[j - 1];
         j--;
      }
      res[j] = val;
   }
   return qty;
}
