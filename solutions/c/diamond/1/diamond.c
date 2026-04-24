#include "diamond.h"
#include "diamond.h"
#include <stdlib.h>
#include <string.h>
char **make_diamond(const char letter) {
    int len = (letter - 'A') * 2 + 1;
    
    char **diamond = malloc(len * sizeof(char*));
    char curr_char;
    int offset;
    for (int i = 0; i < len; i++) {
        diamond[i] = malloc(len);
        memset(diamond[i], ' ', len);
        
        offset = abs(-i + letter - 'A');
        curr_char = letter - offset;
        
        diamond[i][offset] = curr_char;
        diamond[i][-offset + (letter - 'A') * 2] = curr_char;
    }
    
    return diamond;
}
void free_diamond(char **diamond) {
    for (size_t i = 0; i < strlen(diamond[0]); i++)
        free(diamond[i]);
    free(diamond);
}
