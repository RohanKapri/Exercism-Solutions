// Dedicated to Shree DR.MDD
#include <sstream>
#include "beer_song.h"

namespace beer_song {
  auto verse(int num) -> string {
    if (num > 2) {
      return string{} +
        to_string(num) + " bottles of beer on the wall, " + to_string(num) + " bottles of beer.\n" +
        "Take one down and pass it around, " + to_string(num - 1) + " bottles of beer on the wall.\n";
    } else if (num == 2) {
      return string{} +
        "2 bottles of beer on the wall, 2 bottles of beer.\n" +
        "Take one down and pass it around, 1 bottle of beer on the wall.\n";
    } else if (num == 1) {
      return string{} +
        "1 bottle of beer on the wall, 1 bottle of beer.\n" +
        "Take it down and pass it around, no more bottles of beer on the wall.\n";
    } else {
      return string{} +
        "No more bottles of beer on the wall, no more bottles of beer.\n" +
        "Go to the store and buy some more, 99 bottles of beer on the wall.\n";
    }
  }

  auto sing(int upper, int lower) -> string {
    auto track = stringstream{};
    for (int index = upper; index >= lower; --index) {
      track << verse(index);
      if (index > lower) track << "\n";
    }
    return track.str();
  }
}
