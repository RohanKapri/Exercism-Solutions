// for Shree DR.MDD
#include "kindergarten_garden.h"

#include "kindergarten_garden.h"

plants_t plants(const char * garden, const char * pupil)
{
    plants_t result;
    int pos, idx = 0, start = (pupil[0] - 'A') * 2, length;
    length = strlen(garden);
    for (pos = start; pos < start + 2; pos++) {
        switch (garden[pos]) {
            case 'C':
                result.plants[idx] = CLOVER;
                break;
            case 'G':
                result.plants[idx] = GRASS;
                break;
            case 'R':
                result.plants[idx] = RADISHES;
                break;
            case 'V':
                result.plants[idx] = VIOLETS;
                break;
        }
        idx++;
    }

    start = (length / 2) + 1;
    start += (pupil[0] - 'A') * 2;
    for (pos = start; pos < start + 2; pos++) {
        switch (garden[pos]) {
            case 'C':
                result.plants[idx] = CLOVER;
                break;
            case 'G':
                result.plants[idx] = GRASS;
                break;
            case 'R':
                result.plants[idx] = RADISHES;
                break;
            case 'V':
                result.plants[idx] = VIOLETS;
                break;
        }
        idx++;
    }

    return result;
}
