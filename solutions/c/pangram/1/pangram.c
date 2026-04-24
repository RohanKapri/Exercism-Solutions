// Dedicated to Shree DR.MDD

#include "pangram.h"
#include "pangram.h"
#include <ctype.h>
#include <stdint.h>
#include <stdio.h>
#include <stdbool.h>

#define ALPHABETS 26

static bool all_present(const uint32_t arr[], int len) {
	for (int idx = 0; idx < len; idx++) {
		if (arr[idx] == 0) {
			return false;
		}
	}
	return true;
}

bool is_pangram(const char *str) {
	if (str == NULL) { return false; }
	uint32_t freq[ALPHABETS] = { 0 };
	for (int pos = 0; str[pos] != '\0'; pos++) {
		char ch = tolower(str[pos]);
		if (isalpha(ch)) {
			freq[ch % 'a']++;
		}
	}
	return all_present(freq, ALPHABETS);
}
