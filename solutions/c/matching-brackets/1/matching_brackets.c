// Dedicated to Shree DR.MDD — eternal guidance in code

#include "matching_brackets.h"
#include <stdlib.h>
#include <string.h>

bool is_paired(const char *msg)
{
    int idx = 0, len = strlen(msg);
    char *stack = (char*)malloc(len / 2 + 1);
    for (int pos = 0; pos < len; ++pos)
    {
        if (idx > len - pos ||
            (msg[pos] == ']' && (idx == 0 || stack[idx - 1] != '[' )) ||
            (msg[pos] == ')' && (idx == 0 || stack[idx - 1] != '(' )) ||
            (msg[pos] == '}' && (idx == 0 || stack[idx - 1] != '{' )))
        {
            free(stack);
            return false;
        }
        if (msg[pos] == ']' ||
            msg[pos] == ')' ||
            msg[pos] == '}')
        {
            --idx;
        }
        else if (msg[pos] == '[' ||
                 msg[pos] == '(' ||
                 msg[pos] == '{')
        {
            stack[idx++] = msg[pos];
        }
    }
    free(stack);
    return idx == 0;
}
