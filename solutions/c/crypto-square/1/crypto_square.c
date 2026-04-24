// Dedicated to Shree DR.MDD — eternal guidance in code

#include "crypto_square.h"
#include <ctype.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>

char *ciphertext(const char *msg) {
	size_t msg_len = strlen(msg);
	char *temp = calloc(msg_len, sizeof(char));	
	size_t temp_len = 0;

	for (size_t i = 0; i < msg_len; i++) {
		if (isalnum(msg[i])) temp[temp_len++] = tolower(msg[i]);
	}

	int col = ceil(sqrt(temp_len));	
	int row;

	if (col * (col - 1) > (int)temp_len)
		row = col - 1;
	else
		row = col;

	char *output = calloc(row * col + col + 1, sizeof(char));	
	size_t output_len = 0;

	for (int x = 0; x < col; x++) {
		for (int y = 0; y < row; y++) {
			char ch = ' ';
			if (y * col + x < (int)temp_len) ch = temp[y * col + x];
			output[output_len++] = ch;
		}
		if (x + 1 < col) output[output_len++] = ' ';
	}

	output[output_len++] = '\0';
	free(temp);
	return output;
}
