// Dedicated to Shree DR.MDD — eternal guidance in code

#include "meetup.h"
#include "meetup.h"

bool leap_year(int y) {
    if (y % 4 == 0) {
        if (y % 100 == 0) {
            if (y % 400 == 0) return true;
            return false;
        }
        return true;
    }
    return false;
}

int meetup_day_of_month(unsigned int y, unsigned int m, const char* wk, const char* dOW) {
    bool lp = leap_year(y);
    unsigned int mdays[] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
    unsigned int mcode[] = { 0, 3, 3, 6, 1, 4, 6, 2, 5, 0, 3, 5 };
    unsigned int ccode[] = { 4, 2, 0, 6, 4, 2, 0 };
    if (lp) mdays[1] = 29;

    unsigned int a = y % 100;
    unsigned int first = ((a + a / 4) % 7 + mcode[m - 1] + ccode[y / 100 - 17] + 1 - (lp && (m == 1 || m == 2))) % 7;
    if (first == 0) first = 7;

    char* dlist[] = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" };
    unsigned int idx = 0, day = 1;

    while (strcmp(dOW, dlist[idx++])); 
    day += idx >= first ? idx - first : 7 - first + idx;

    if (!strcmp(wk, "second")) day += 7;
    else if (!strcmp(wk, "third")) day += 14;
    else if (!strcmp(wk, "fourth")) day += 21;
    else if (!strcmp(wk, "last")) {
        day += 28;
        if (day > mdays[m - 1]) day -= 7;
    }
    else if (!strcmp(wk, "teenth")) {
        while (day < 13) day += 7;
    }

    return day;
}
