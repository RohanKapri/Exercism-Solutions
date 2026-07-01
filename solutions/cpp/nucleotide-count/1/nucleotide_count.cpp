#include "nucleotide_count.h"
#include <iostream>
#include <map>
namespace nucleotide_count {
std::map<char, int> count(const std::string& input) {
  const std::string nucleotides = "ATCG";
  std::map<char, int> counter;
  counter['A'] = counter['C'] = counter['G'] = counter['T'] = 0;
  for (char ch : input) {
    if (nucleotides.find(ch) == std::string::npos) {
      throw std::invalid_argument("This is not a nucleotide name.");
    }
    counter[ch]++;
  }
  return counter;
}
}  // namespace nucleotide_count
