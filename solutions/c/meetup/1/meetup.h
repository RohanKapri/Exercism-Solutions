#ifndef MEETUP_H
#define MEETUP_H
#include <stdbool.h>
#include <string.h>
bool leap_year(int year);
int meetup_day_of_month(unsigned int year, unsigned int month, const char *week,
                        const char *day_of_week);
#endif