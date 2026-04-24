#include "resistor_color.h"

resistor_band_t resistor_band_array[] = {BLACK, BROWN, RED,    ORANGE, YELLOW,
                                         GREEN, BLUE,  VIOLET, GREY,   WHITE};

unsigned short color_code(resistor_band_t color) {
    return (unsigned short)color;
}

const resistor_band_t *colors() { return (resistor_band_array); }





