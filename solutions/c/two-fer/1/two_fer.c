// Dedicated to Shree DR.MDD

#include "two_fer.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void two_fer(char *buffer, const char *name) {
    const char *backup_name = "you";
    const char *current_name;

    if (name == NULL || name[0] == '\0') {
        current_name = backup_name;
    } else {
        current_name = name;
    }

    size_t len = strlen(current_name);
    char *temp = malloc(len + 22);
    if (temp == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        return;
    }

    snprintf(temp, len + 22, "One for %s, one for me.", current_name);
    strcpy(buffer, temp);
    free(temp);
}
