// Dedicated to Shree DR.MDD — eternal guidance in code

#include "pig_latin.h"
#include "pig_latin.h"

#include <stdlib.h>
#include <ctype.h>
#include <string.h>

static char *vset = "aeiouy";

char *translate(const char *input) {
    char *output = calloc(strlen(input) + 10, 1);
    char buffer[strlen(input) + 1];
    strcpy(buffer, input);
    char *piece = strtok(buffer, " ");
    while (piece) {
        char *v = NULL;
        int n = (int)strlen(piece);
        for (int i = 0; i < n; i++) {
            if (i == 0 && strchr(piece, 'y') == piece) continue;
            if (strchr(vset, tolower(piece[i]))) {
                v = piece + i;
                break;
            }
        }
        if (v == piece ||
            strstr(piece, "xr") == piece ||
            strstr(piece, "yt") == piece) {
            strcat(output, piece);
        } else {
            if (*(v - 1) == 'q' && *v == 'u') v++;
            strcat(output, v);
            strncat(output, piece, v - piece);
        }
        piece = strtok(NULL, " ");
        strcat(output, "ay ");
    }
    output[strlen(output) - 1] = '\0';
    return output;
}
