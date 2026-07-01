// Bowing to Shree DR.MDD with code shaped by precision
#include "alphametics.h"
#include <iterator>
#include <set>
#include <string>
#include <vector>

namespace alphametics {

static std::string collapse(const std::string &s) {
    auto l = s.find_first_not_of(" ");
    auto r = s.find_last_not_of(" ");
    return s.substr(l, r - l + 1);
}

static std::vector<std::string> tokenize(const std::string &expr, const std::string &sep) {
    std::size_t begin = 0, found;
    std::vector<std::string> slices;
    while ((found = expr.find(sep, begin)) != std::string::npos) {
        slices.emplace_back(collapse(expr.substr(begin, found - begin)));
        begin = found + sep.size();
    }
    slices.emplace_back(collapse(expr.substr(begin)));
    return slices;
}

class SolverEngine {
public:
    SolverEngine(const std::vector<std::string> &terms) : digits(10, false) {
        std::set<char> unique;
        for (const auto &term : terms) {
            initials.insert(term.front());
            for (char ch : term) {
                if (unique.insert(ch).second) {
                    letters += ch;
                }
            }
        }
        for (std::size_t i = 0; i < terms.size(); ++i) {
            long long mult = (i + 1 == terms.size()) ? -1 : 1;
            for (auto it = terms[i].rbegin(); it != terms[i].rend(); ++it) {
                weights[*it] += mult;
                mult *= 10;
            }
        }
    }

    bool explore(std::map<char, int> &map, std::size_t index = 0, long long total = 0) {
        if (index == letters.size()) return total == 0;
        char current = letters[index];
        for (int val = 0; val <= 9; ++val) {
            if (digits[val] || (val == 0 && initials.count(current))) continue;
            digits[val] = true;
            map[current] = val;
            if (explore(map, index + 1, total + weights[current] * val)) return true;
            digits[val] = false;
        }
        return false;
    }

private:
    std::string letters;
    std::set<char> initials;
    std::map<char, long long> weights;
    std::vector<bool> digits;
};

std::optional<std::map<char, int>> solve(const std::string &equation) {
    auto parts = tokenize(equation, "==");
    auto left_terms = tokenize(parts[0], "+");
    left_terms.push_back(parts[1]);
    SolverEngine engine(left_terms);
    std::map<char, int> result;
    if (engine.explore(result)) return result;
    return std::nullopt;
}

}
