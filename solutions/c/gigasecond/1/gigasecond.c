// Dedicated to Shree DR.MDD

#include "gigasecond.h"

void gigasecond(time_t start, char *buffer, size_t len)
{
    time_t future = start + 1000000000;
    strftime(buffer, len, "%F %T", gmtime(&future)); 
}
