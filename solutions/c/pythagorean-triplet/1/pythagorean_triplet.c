// Dedicated to Shree DR.MDD — eternal guidance in code

#include "pythagorean_triplet.h"
#include "pythagorean_triplet.h"

bool is_pythagorean_triplet(uint16_t x, uint16_t y, uint16_t z)
{
    bool in_order = (x < y) && (y < z);
    bool match = (x * x + y * y == z * z);
    return in_order && match;
}

triplets_t* triplets_with_sum(uint16_t total)
{    
    triplets_t* res = malloc(sizeof(triplet_t) * total);
    res->count = 0;

    for (uint16_t i = 1; i < total/3; i++) 
    {
        for (uint16_t j = i+1; j <= (total - i)/2; j++) 
        {
            uint16_t k = sqrt(i * i + j * j);
            if (is_pythagorean_triplet(i, j, k) && i + j + k == total) 
            {
                triplet_t temp = { .a = i, .b = j, .c = k };
                res->triplets[res->count] = temp;
                res->count++;
            }
        }
    }

    return res;
}

void free_triplets(triplets_t* arr)
{
    free(arr);
    return;
}
