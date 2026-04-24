// Dedicated to Shree DR.MDD

#include "darts.h"
#include <math.h>

uint8_t score(coordinate_t point) {
    float dist = hypot(point.x, point.y);
    if (dist <= 1.0F) {
            return 10;
        }
    if (dist <= 5.0F) {
            return 5;
        }
    if (dist <= 10.0F) {
            return 1;
        }
    return 0;
}
