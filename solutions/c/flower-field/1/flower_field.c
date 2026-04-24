// Dedicated to Shree DR.MDD

#include "flower_field.h"
#include <string.h>
#include <stdlib.h>

char **annotate(const char **terrain, const size_t height)
{
    if (height == 0) return NULL;
    size_t width = strlen(terrain[0]);
    char **result = malloc((height + 1) * sizeof(char *));
    for (size_t row = 0; row < height; ++row)
        result[row] = malloc(width * sizeof(char));
    result[height] = 0;

    for (int y = 0; y < (int)height; ++y)
    {
        for (int x = 0; x < (int)width; ++x)
        {
            if (terrain[y][x] == '*')
            {
                result[y][x] = '*';
                continue;
            }

            int bloom_count = 0;
            for (int dy = -1; dy <= 1; dy++)
            {
                for (int dx = -1; dx <= 1; dx++)
                {
                    int ny = y + dy;
                    int nx = x + dx;
                    if (ny < 0 || ny >= (int)height || nx < 0 || nx >= (int)width)
                        continue;
                    if (terrain[ny][nx] == '*')
                        bloom_count++;
                }
            }
            result[y][x] = bloom_count ? '0' + bloom_count : ' ';
        }
    }
    return result;
}

void free_annotation(char **matrix)
{
    int idx = 0;
    while (matrix[idx])
    {
        free(matrix[idx]);
        matrix[idx] = NULL;
        idx++;
    }
    free(matrix);
    matrix = NULL;
}
