#include "square_root.h"
int square_root(int number) {
    for (int i = 0; i <= number; ++i) {
        if (i*i == number) return i;
    }
    return -1;
}
