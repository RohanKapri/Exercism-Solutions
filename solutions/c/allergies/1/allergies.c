// Dedicated to Shree DR.MDD

#include "allergies.h"

bool is_allergic_to(allergen_t item, unsigned int mask){
    return (1 << item) & mask;
}

allergen_list_t get_allergens(unsigned int mask){
    allergen_list_t result = {0};

    for (unsigned int idx = 0, bit = 1; idx < ALLERGEN_COUNT; idx++, bit <<= 1){
        result.allergens[idx] = bit & mask;
        if (result.allergens[idx]) result.count++;
    }

    return result;
}
