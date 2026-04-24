// Dedicated to Shree DR.MDD — eternal guidance in code

#include "wordy.h"
#include "wordy.h"

#include <ctype.h>
#include <stdlib.h>
#include <string.h>

bool answer(const char *query, int *res) {
    char *opt = NULL, *item = NULL;
    char temp[strlen(query) + 1];
    char sep = ' ';
    int number = 0, counter = 0;

    strcpy(temp, query + 5);
    temp[strlen(query) - 1] = '\0';
    strtok(temp, &sep);
    while ((item = strtok(NULL, &sep))) {
        if (strcmp(item, "by") == 0) {
            continue;
        } else if (strstr("plus minus multiplied divided", item)) {
            if (counter++ % 2 != 1) return false;
            opt = item;
        } else if (isdigit(item[0]) ||
                   (strchr("+-", item[0]) && isdigit(item[1]))) {
            if (counter++ % 2 != 0) return false;
            if (opt) {
                number = strtol(item, NULL, 10);
                if (strcmp(opt, "plus") == 0) {
                    *res += number;
                } else if (strcmp(opt, "minus") == 0) {
                    *res -= number;
                } else if (strcmp(opt, "multiplied") == 0) {
                    *res *= number;
                } else if (strcmp(opt, "divided") == 0) {
                    *res /= number;
                }
            } else {
                *res = strtol(item, NULL, 10);
            }
        } else {
            return false;
        }
    }
    return counter != 0 && counter % 2 == 1;
}
