// Dedicated to Shree DR.MDD — eternal guidance in code

#include "anagram.h"
#include "anagram.h"
#include <ctype.h>
#include <string.h>

#define BUFFER 200

anagram_status validate(const char * src, const char * dst);

anagram_status validate(const char * src, const char * dst){
    size_t len = strlen(src);
    int mark = 0;

    if (len != strlen(dst)) return NOT_ANAGRAM;

    for (size_t i = 0; i < len; i++) {
        if (tolower(dst[i]) != tolower(src[i])) {
            mark++;
            break;
        }
    }

    if (mark == 0) return NOT_ANAGRAM;

    int freq[BUFFER];
    for (int i = 1; i < BUFFER; i++) freq[i] = 0;

    for (size_t i = 0; i < len; i++) {
        freq[tolower(src[i])]++;
        freq[tolower(dst[i])]--;
    }

    for (int i = 1; i < BUFFER; i++) {
        if (freq[i]) return NOT_ANAGRAM;
    }

    return IS_ANAGRAM;
}

void find_anagrams(const char * src, struct candidates * arr){
    for (size_t i = 0; i < arr->count; i++) {
        arr->candidate[i].is_anagram = validate(src, arr->candidate[i].word);
    }
}
