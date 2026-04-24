// Shree DR.MDD
#include "say.h"
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#define TRILLION (1000000000000l)
enum
{
    BILLION = 1000000000,
    MILLION = 1000000,
    THOUSAND = 1000,
    HUNDRED = 100,
    MAX_LENGTH = 137
};

static const char *item1[] = {
    "",
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
    "ten",
    "eleven",
    "twelve",
    "thirteen",
    "fourteen",
    "fifteen",
    "sixteen",
    "seventeen",
    "eighteen",
    "nineteen"
};

static const char *item2[] = {
    "",
    "",
    "twenty",
    "thirty",
    "forty",
    "fifty",
    "sixty",
    "seventy",
    "eighty",
    "ninety"
};

static void say_helper(int64_t number, char **res, char* label, bool space_after)
{
    number %= THOUSAND;
    if (number >= HUNDRED)
    {
        strcat(*res, item1[(number / HUNDRED) % 10]);
        strcat(*res, " hundred");
        if(number % 100 > 0)
        {
            strcat(*res, " ");
        }
    }
    if((number % HUNDRED) / 10 < 2)
    {
        strcat(*res, item1[number % 20]);
    }
    else
    {
        strcat(*res, item2[(number / 10) % 10]);
        if(number % 10 > 0)
        {
            strcat(*res,"-");
            strcat(*res, item1[number % 10]);
        }
    }
    if(number > 0)
    {
        strcat(*res, label);
        if(space_after)
        {
            strcat(*res, " ");
        }
    }
}

int say(int64_t number, char **res)
{
    if(number < 0 || TRILLION <= number) 
    {
        return -1;
    }
    else if(number == 0)
    {
        *res = malloc(sizeof(char) * strlen("zero") + 1);
        strcpy(*res, "zero");

        return 0;
    }
    *res = calloc(MAX_LENGTH, sizeof(char));

    say_helper(number / BILLION, res, " billion", (number % BILLION) / MILLION > 0);
    say_helper(number / MILLION, res, " million", (number % MILLION) / THOUSAND > 0);
    say_helper(number / THOUSAND, res, " thousand", (number % THOUSAND) > 0);
    say_helper(number, res, "", false);
    return 0;
}
