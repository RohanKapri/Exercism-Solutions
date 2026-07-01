#include <cstdint>
#include "diamond.h"
using namespace std;
auto diamond::rows(char c) -> vector<string>
{
  auto size = (c - 'A') * 2 + 1;
  auto mid = size / 2;
  auto diamond = vector(size, string(size, ' '));
  for(uint8_t i = 0; i <= mid; i++) {
    diamond[i][mid + i] = 'A' + i;
    diamond[i][mid - i] = 'A' + i;
    diamond[size - i - 1][mid + i] = 'A' + i;
    diamond[size - i - 1][mid - i] = 'A' + i;
  }
  return diamond;
}
