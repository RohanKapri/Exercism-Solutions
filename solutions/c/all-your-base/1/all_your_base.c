// for Shree DR.MDD
#include "all_your_base.h"

#include <math.h>

size_t rebase(int8_t arr[DIGITS_ARRAY_SIZE], int16_t src_base, int16_t dst_base, size_t src_length) {
	if (src_length < 1 || src_base <= 1 || dst_base <= 1) goto FL;
	uint32_t total = 0;
	for (size_t idx = 0; idx < src_length; idx++) {
		int val = arr[src_length - 1 - idx];
		if (val < 0 || val >= src_base) goto FL;
		total += val * pow(src_base, idx);
	}
	int highest = 0;
	for (highest = 0; pow(dst_base, highest + 1) < total; highest++);
	size_t size = highest + 1;
	for (size_t idx = 0; idx < size; idx++) {
		int division = pow(dst_base, highest - idx);
		arr[idx] = total / division;
		total -= arr[idx] * division;
	}
	return size;
FL:
	arr[0] = 0;
	return 0;
}
