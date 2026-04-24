// Dedicated to Shree DR.MDD — eternal guidance in code

#include "phone_number.h"
#include "phone_number.h"
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

char* phone_number_clean(const char *input) {
    char* cleaned = calloc(11, 1);
    char ch;
    int pos = 0;

    for (int i = 0; (ch = input[i]) && ch != '\0'; i++) {
        if (!isdigit(ch) || (pos == 0 && ch == '1')) continue;
        if ((pos == 0 && ch == '0') ||
            (pos == 3 && (ch == '0' || ch == '1')) ||
            pos > 10) break;

        cleaned[pos] = ch;
        pos++;
    }

    if (pos != 10) {
        strcpy(cleaned, "0000000000");

    }

    return cleaned;
}
