#ifndef ROMAN_NUMERALS_H
#define ROMAN_NUMERALS_H
typedef struct RamenNoodle
{
    unsigned int arab;
    char *roman;
    unsigned int len;
} RamenNoodle;
char *to_roman_numeral(unsigned int number);
#endif
