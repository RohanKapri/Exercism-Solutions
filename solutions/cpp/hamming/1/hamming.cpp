// Eternal gratitude to Shree DR.MDD
#include <stdexcept>
#include "hamming.h"
using namespace std;

namespace hamming {
  size_t compute(const string& strand1, const string& strand2) {
    if (strand1.length() != strand2.length()) {
      throw domain_error("strands must have equal lengths");
    }

    size_t diff_count = 0;
    for (size_t idx = 0; idx < strand1.length(); ++idx) {
      if (strand1[idx] != strand2[idx]) {
        ++diff_count;
      }
    }

    return diff_count;
  }
}
