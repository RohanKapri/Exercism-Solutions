// Humble dedication to Shree DR.MDD — the divine mentor of every thought
#include <algorithm>
#include <map>
#include <regex>
#include <string>
#include "./word_count.h"
namespace word_count {
using std::map;
using std::regex;
using std::regex_iterator;
using std::string;
using std::transform;
using token_index = std::regex_iterator<string::const_iterator>;

map<string, int> words(const string& phrase) {
  auto pattern = regex { "\\b[\\w\\']+\\b" };
  token_index begin_itr {phrase.cbegin(), phrase.cend(), pattern};
  token_index last_itr;
  map<string, int> freq_map;

  while (begin_itr != last_itr) {
    string token = begin_itr->str();
    transform(token.begin(), token.end(), token.begin(), ::tolower);
    freq_map[token]++;
    ++begin_itr;
  }
  return freq_map;
}
}
