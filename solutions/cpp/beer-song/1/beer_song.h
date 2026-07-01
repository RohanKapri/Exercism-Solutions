#ifndef BEER_SONG_H
#define BEER_SONG_H
#include <string>
namespace beer_song {
  using namespace std;
  auto verse(int which) -> string;
  auto sing(int from, int to = 0) -> string;
}
#endif
