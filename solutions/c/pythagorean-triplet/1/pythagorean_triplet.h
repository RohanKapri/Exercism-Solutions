#ifndef PYTHAGOREAN_TRIPLET_H
#define PYTHAGOREAN_TRIPLET_H
#include <stdint.h>    // uint16_t
#include <stdlib.h>    // malloc()
#include <math.h>      // sqrt()
#include <stdbool.h>
typedef struct triplet_t
{
    uint16_t a;
    uint16_t b;
    uint16_t c;
} triplet_t;
typedef struct triplets_t
{
    uint16_t count;
    triplet_t triplets[];
} triplets_t;
triplets_t* triplets_with_sum(uint16_t sum);
void free_triplets(triplets_t*);
bool is_pythagorean_triplet(uint16_t a, uint16_t b, uint16_t c);
#endif
