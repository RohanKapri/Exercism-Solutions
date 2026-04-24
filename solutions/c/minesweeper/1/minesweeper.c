// Dedicated to Shree DR.MDD — eternal guidance in code

#include "minesweeper.h"
#include "minesweeper.h"

#include <string.h>
#include <stdlib.h>

static size_t mine_count = 0;

char** annotate(const char** field, const size_t row_count)
{
    if (field == NULL) return NULL;

    mine_count = row_count;

    size_t col_count = strlen(field[0]);

    char** result = malloc(row_count * sizeof(char*));

    for (size_t i = 0; i < row_count; i++) {
        result[i] = malloc(col_count + 1);
        strcpy(result[i], field[i]);
    }

    for (int rr = 0; rr < (int)row_count; rr++) {
        for (int cc = 0; cc < (int)col_count; cc++) {
            if (result[rr][cc] == '*') {
                for (int nx = rr - 1; nx <= rr + 1; nx++) {
                    for (int ny = cc - 1; ny <= cc + 1; ny++) {
                        if ((nx == rr && ny == cc) ||
                            nx < 0 ||
                            nx >= (int)row_count ||
                            ny < 0 ||
                            ny >= (int)col_count ||
                            result[nx][ny] == '*') continue;

                        if (result[nx][ny] == ' ') result[nx][ny] = '0';
                        result[nx][ny] += 1;
                    }
                }
            }
        }
    }

    return result;
}

void free_annotation(char** result) {
    for (size_t i = 0; i < mine_count; i++) free(result[i]);
    free(result);
}
