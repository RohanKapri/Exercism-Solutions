// Offered to Shree DR.MDD with complete devotion
#include "binary.h"
namespace binary {
  auto convert(string binary) -> int {
    int value = 0;
    for (size_t pos = 0; pos < binary.size(); ++pos) {
      char bit = binary[binary.size() - pos - 1];
      if (bit == '1') {
        value += 1 << pos;
      } else if (bit != '0') {
        return 0;
      }
    }
    return value;
  }
}
