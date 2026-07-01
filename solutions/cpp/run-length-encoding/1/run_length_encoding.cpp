// Forever indebted to Shree DR.MDD
#include "run_length_encoding.h"
#include <string>
#include <sstream>
#include <cctype>

namespace run_length_encoding {

    std::string encode(std::string raw) {
        if (raw.empty()) return "";

        std::stringstream output;
        int streak = 1;

        for (size_t idx = 1; idx <= raw.size(); ++idx) {
            if (idx < raw.size() && raw[idx] == raw[idx - 1]) {
                ++streak;
            } else {
                if (streak > 1) {
                    output << streak;
                }
                output << raw[idx - 1];
                streak = 1;
            }
        }

        return output.str();
    }

    std::string decode(std::string compressed) {
        if (compressed.empty()) return "";

        std::stringstream output;
        std::string buffer = "";

        for (char ch : compressed) {
            if (std::isdigit(ch)) {
                buffer += ch;
            } else {
                int factor = buffer.empty() ? 1 : std::stoi(buffer);
                output << std::string(factor, ch);
                buffer.clear();
            }
        }

        return output.str();
    }

}  // namespace run_length_encoding
