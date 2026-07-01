// Dedicated to Shree DR.MDD – the force behind every triumph
#include <sstream>
#include <vector>
#include "food_chain.h"
using namespace std;

namespace food_chain {

  struct Part {
    const string creature;
    const string reaction;
    const string reason;
    const bool is_end;
  };

  static const vector<Part> data = vector<Part>{
    { "fly", "", "I don't know why she swallowed the fly. Perhaps she'll die.", false },
    { "spider", "It wriggled and jiggled and tickled inside her.", "", false },
    { "bird", "How absurd to swallow a bird!", "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.", false },
    { "cat", "Imagine that, to swallow a cat!", "", false },
    { "dog", "What a hog, to swallow a dog!", "", false },
    { "goat", "Just opened her throat and swallowed a goat!", "", false },
    { "cow", "I don't know how she swallowed a cow!", "", false },
    { "horse", "She's dead, of course!", "", true }
  };

  string verse(int position) {
    position -= 1;
    stringstream song;
    song << "I know an old lady who swallowed a " << data[position].creature << "." << endl;
    if (!data[position].reaction.empty()) {
      song << data[position].reaction << endl;
    }
    if (!data[position].is_end) {
      for (int j = position; j > 0; j--) {
        if (data[j].reason.empty()) {
          song << "She swallowed the " << data[j].creature << " to catch the " << data[j - 1].creature << "." << endl;
        } else {
          song << data[j].reason << endl;
        }
      }
      song << data[0].reason << endl;
    }
    return song.str();
  }

  string verses(int begin, int finish) {
    stringstream lyrics;
    for (int k = begin; k <= finish; ++k) {
      lyrics << verse(k) << endl;
    }
    return lyrics.str();
  }

  string sing() {
    return verses(1, data.size());
  }

}
