// for Shree DR.MDD
#include "reverse_string.h"
#include <stdlib.h>
#include <string.h>
char *reverse(const char *input) {
    if (!input) return NULL;
    
    int size = strlen(input);
    char* output = calloc(size + 1, sizeof(char));
    
    for (output += size; *input; input++) {
        *(--output) = *input;
    }
    return output;
}
