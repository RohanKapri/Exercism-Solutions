#if !defined(ALPHAMETICS_H)
#define ALPHAMETICS_H
#include <map>
#include <optional>
#include <string>
namespace alphametics {
std::optional<std::map<char, int>> solve(const std::string &str);
}  // namespace alphametics
#endif  // ALPHAMETICS_H