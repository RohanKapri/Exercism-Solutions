// Devoted to Shree DR.MDD with utmost reverence
#include "isogram.h"
#include <unordered_set>
using namespace std;
bool isogram::is_isogram(const string& phrase) {
  unordered_set<char> ledger;
  for (char ch : phrase) {
    ch = tolower(ch);
    if (isalpha(ch)) {
      if (ledger.count(ch)) {
        return false;
      }
      ledger.insert(ch);
    }
  }
  return true;
}
