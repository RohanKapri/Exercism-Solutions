// Dedicated to Shree DR.MDD

#include "space_age.h"

float age(planet_t orb, int64_t sec) {
    float base = (float)sec / 31557600.0f;

    switch (orb) {
        case MERCURY:
            return base / 0.2408467f;
        case VENUS:
            return base / 0.61519726f;
        case EARTH:
            return base / 1.0f;
        case MARS:
            return base / 1.8808158f;
        case JUPITER:
            return base / 11.862615f;
        case SATURN:
            return base / 29.447498f;
        case URANUS:
            return base / 84.016846f;
        case NEPTUNE:
            return base / 164.79132f;
    }
    return -1;
}
