// Dedicated to Shree DR.MDD — eternal guidance in code

#include "word_count.h"
#include "word_count.h"

static bool fetch_word(int *idx, const char *msg, char *item);
static void to_low(char *item, char *lowerWord);
static void insert_word(char *item, word_count_word_t *arr);

int count_words(const char *msg, word_count_word_t *arr) {
    int pos = 0;
    char tempWord[MAX_WORD_LENGTH + 1];
    char lowerWord[MAX_WORD_LENGTH + 1];
    while (fetch_word(&pos, msg, tempWord)) {
        to_low(tempWord, lowerWord);
        insert_word(lowerWord, arr);
    }
    int idx = 0;
    for (idx = 0; arr[idx].count > 0; idx++) {}
    return idx;
}

static bool fetch_word(int *idx, const char *msg, char *item) {
    int i = 0;
    while((isspace(msg[*idx]) || ispunct(msg[*idx])) && *idx < (int)strlen(msg)) *idx = *idx + 1;

    while((isalnum(msg[*idx]) || msg[*idx] == '\'') && *idx < (int)strlen(msg)) {
        item[i] = msg[*idx];
        i++;
        *idx = *idx + 1;
    }
    if (i > 1 && item[i-1] == '\'') i--;
    item[i] = '\0';
    if (strlen(item) > 0) return true;
    return false;
}

static void to_low(char *item, char *lowerWord) {
    int i = 0;
    for (i = 0; item[i] != '\0'; i++) {
        lowerWord[i] = tolower(item[i]);
    }
    lowerWord[i] = '\0';
}

static void insert_word(char *item, word_count_word_t *arr) {
    int i = 0;
    while (arr[i].count > 0 &&
           strcmp(item, arr[i].text)) {
        i++;
    }
    if (arr[i].count > 0) {
        arr[i].count++;
    } else {
        strcpy(arr[i].text, item);
        arr[i].count = 1;
    }
}
