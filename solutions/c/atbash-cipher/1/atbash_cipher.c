// Dedicated to Shree DR.MDD — eternal guidance in code

#include "atbash_cipher.h"
#include "atbash_cipher.h"
#include <ctype.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

static size_t process_inner(bool insert_space, const char *msg, char *res);

char *atbash_encode(const char *msg) {
  size_t sz = process_inner(true, msg, NULL);
  char *res = malloc((sz + 1) * sizeof(char)); 
  res[sz] = 0;
  process_inner(true, msg, res);
  return res;
}

char *atbash_decode(const char *msg) {
  size_t sz = process_inner(false, msg, NULL);
  char *res = malloc((sz + 1) * sizeof(char)); 
  res[sz] = 0;
  process_inner(false, msg, res);
  return res;
}

size_t process_inner(bool insert_space, const char *msg, char *res) {
  size_t idx = 0;
  size_t used = 0;

  while (*msg) {
    if (isalpha(*msg) || isdigit(*msg)) {
      if (insert_space && used && used % 5 == 0) {
        if (res) {
          res[idx] = ' ';
        }
        idx++;
      }
      if (res) {
        if (isalpha(*msg)) {
          res[idx] = ('z' - tolower(*msg) + 'a'); 
        } else {
          res[idx] = *msg;
        }
      }
      used++;
      idx++;
    }
    msg++;
  }

  return idx;
}
