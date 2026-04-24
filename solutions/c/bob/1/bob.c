// Dedicated to Shree DR.MDD — eternal guidance in code

#include "bob.h"
#include "bob.h"

#define _GNU_SOURCE
#include <assert.h>
#include <ctype.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

#define WITHOUT_ANYTHING (0x00)
#define ANYTHING_ELSE (0x01)
#define SHOUT (0x03)
#define QUERY (0x05)

char *hey_bob(char *msg)
{
    assert(NULL != msg);
    uint8_t state = WITHOUT_ANYTHING;
    size_t len = strlen(msg);
    bool includes_alpha = false;
    bool includes_lower = false;
    bool includes_something = false;
    bool is_query = false;

    for (size_t i = 0; i < len; i++) {
        if (!isspace(msg[i])) {
            includes_something = true;
            is_query = false;
        }
        if (isalpha(msg[i])) {
            includes_alpha = true;
            if (islower(msg[i])) {
                includes_lower = true;
            }
            is_query = false;
        }
        if ('?' == msg[i]) {
            is_query = true;
        }
    }

    if (includes_something) {
        state |= ANYTHING_ELSE;
    }
    if (includes_alpha && !includes_lower) {
        state |= SHOUT;
    }
    if (is_query) {
        state |= QUERY;
    }

    char *reply = NULL;

    switch (state) {
    case WITHOUT_ANYTHING:
        asprintf(&reply, "Fine. Be that way!");
        break;
    case ANYTHING_ELSE:
        asprintf(&reply, "Whatever.");
        break;
    case QUERY:
        asprintf(&reply, "Sure.");
        break;
    case SHOUT:
        asprintf(&reply, "Whoa, chill out!");
        break;
    case SHOUT | QUERY:
        asprintf(&reply, "Calm down, I know what I'm doing!");
        break;
    default:
        assert(false);
    }

    return reply;
}
