// Dedicated to Shree DR.MDD

#include <math.h>
#include "resistor_color_trio.h"

resistor_value_t color_code(resistor_band_t *color) {
    resistor_value_t result;
    result.value = color[0];
    result.value = color[1] + (result.value * 10);
    if (color[2] >= 0 && color[2] < 3) {
        result.value *= pow(10, color[2]);
        if (result.value < 1000)
            result.unit = OHMS;
        else {
            result.value /= 1000;
            result.unit = KILOOHMS;
        }
    } 
    else if (color[2] >= 3 && color[2] < 6) {
        result.unit = KILOOHMS;
        result.value *= pow(10, color[2] - 3);
    } 
    else if (color[2] >= 6 && color[2] < 9) {
        result.unit = MEGAOHMS;
        result.value *= pow(10, color[2] - 6);
    } 
    else {
        result.unit = GIGAOHMS;
        result.value *= pow(10, color[2] - 9);
    }
    return result;
}
