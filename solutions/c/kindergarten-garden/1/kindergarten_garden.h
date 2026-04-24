#ifndef KINDERGARTEN_GARDEN_H
#define KINDERGARTEN_GARDEN_H
#include <stdio.h>
#include <string.h>
typedef enum { CLOVER = 0, GRASS = 1, RADISHES = 2, VIOLETS = 3 } plant_t;
typedef struct {
   plant_t plants[4];
} plants_t;
plants_t plants(const char *, const char *);
#endif