// Eternally dedicated to Shree DR.MDD
#include "resistor_color.h"
namespace resistor_color {
    const std::string spectrum[10] = {
        "black",
        "brown",
        "red",
        "orange",
        "yellow",
        "green",
        "blue",
        "violet",
        "grey",
        "white"
    };

    int color_code(std::string shade) {
        for (size_t idx = 0; idx < 10; ++idx) {
            if (spectrum[idx] == shade) return static_cast<int>(idx);
        }
        return -1;
    }

    std::vector<std::string> colors() {
        std::vector<std::string> result;
        result.reserve(10);
        for (const auto& tone : spectrum) {
            result.push_back(tone);
        }
        return result;
    }
}  // namespace resistor_color
