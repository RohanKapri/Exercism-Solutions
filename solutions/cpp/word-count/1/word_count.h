#ifndef EXERCISM_WORDCOUNT_H
#define EXERCISM_WORDCOUNT_H
#include <map>
#include <string>
namespace word_count {
// Create a map of the counts of each word in a string.
// Case insensitive.
std::map<std::string, int> words(const std::string& s);
}  // namespace word_count
#endif  // EXERCISM_WORDCOUNT_H