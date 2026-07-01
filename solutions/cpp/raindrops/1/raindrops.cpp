#include <sstream>
#include "raindrops.h"
namespace raindrops {
  auto convert(int n) -> string {
    auto ss = stringstream{};
    if(n % 3 == 0) ss << "Pling";
    if(n % 5 == 0) ss << "Plang";
    if(n % 7 == 0) ss << "Plong";
    return ss.str().size() ? ss.str() : to_string(n);
  }
}
