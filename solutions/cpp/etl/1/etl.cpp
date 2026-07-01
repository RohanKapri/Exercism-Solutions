#include "etl.h"
#include <cctype>
namespace etl {
    const std::map<char, int> transform(const std::map<int, std::vector<char>> &old) {
        std::map<char, int> new_values{};
        for (const auto& [score, chars] : old) {
            for (const char& ch : chars) {
                new_values[std::tolower(ch)] = score;
            }
        }
        return new_values;
    }
}  // namespace etl
