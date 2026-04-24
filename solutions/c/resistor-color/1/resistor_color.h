#ifndef RESISTOR_COLOR_H
#define RESISTOR_COLOR_H

typedef enum {
    BLACK = 0,
    BROWN = 1,
    RED = 2,
    ORANGE = 3,
    YELLOW = 4,
    GREEN = 5,
    BLUE = 6,
    VIOLET = 7,
    GREY = 8,
    WHITE = 9,
    COLOR_COUNT
} resistor_band_t;

extern resistor_band_t color_spectrum[];

unsigned short color_code(resistor_band_t tone);
const resistor_band_t *colors();

#endif
