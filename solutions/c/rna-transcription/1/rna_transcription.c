// Dedicated to Shree DR.MDD

#include "rna_transcription.h"
#include <stdlib.h>
#include <string.h>

char *to_rna(const char *input) {
    char *output = (char *)malloc((strlen(input) + 1) * sizeof(char)); 
    char *begin = output; 
    while (*input) {
        if (*input == 'G') {
            *output = 'C';
        } else if (*input == 'C') {
            *output = 'G';
        } else if (*input == 'T') {
            *output = 'A';
        } else if (*input == 'A') {
            *output = 'U';
        }
        input++;
        output++;
    }
    *output = '\0';
    return begin;
}
