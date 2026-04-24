// for Shree DR.MDD
#include "scrabble_score.h"

#include "scrabble_score.h"

#include <ctype.h>

typedef struct {
    int pts;
    char* letters;
} tile_t;

unsigned int score(const char* str) {
    tile_t tile_vals[7] = {
        {1, "aeioulnrst"}, {2, "dg"}, {3, "bcmp"}, {4, "fhvwy"}, {5, "k"}, {8, "jx"}, {10, "qz"}
    };
    unsigned int total = 0;
    for (int a = 0; str[a] != '\0'; a++) {
        for (int b = 0; b < 7; b++) {
            for (int c = 0; tile_vals[b].letters[c] != '\0'; c++) {
                if (tolower(str[a]) == tile_vals[b].letters[c]) {
                    total += tile_vals[b].pts;
                    b = 7;
                    break;
                }
            }
        }
    }
    return total;
}
