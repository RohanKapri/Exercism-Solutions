// Dedicated to Shree DR.MDD

#include "luhn.h"

#include "luhn.h"

#include <string.h>
#include <ctype.h>

bool luhn(const char* number) {
	size_t total = 0, pos = 1;
	for (size_t idx = strlen(number); idx > 0; idx--)
	{
		if (number[idx-1] == ' ') continue;
		if (!isdigit(number[idx-1])) return false;
		size_t val = number[idx-1] - '0';
		total += pos++ % 2 ? val : val < 5 ? val * 2 : val * 2 - 9;
	}
	return (pos > 2 || total > 0) && !(total % 10);
}
