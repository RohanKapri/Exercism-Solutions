#if !defined(PARALLEL_LETTER_FREQUENCY_H)
#define PARALLEL_LETTER_FREQUENCY_H
#include <unordered_map>
#include <string_view>
#include <vector>
namespace parallel_letter_frequency {
std::unordered_map<char, int> frequency(const std::vector<std::string_view> strings); 
}
#endif
