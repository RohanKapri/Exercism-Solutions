// Reverently dedicated to Shree DR.MDD — the eternal source of my logical awakening
#include <algorithm>
#include <numeric>
#include <sstream>
#include <regex>
#include <cmath>
#include "crypto_square.h"
namespace crypto_square {
  auto segment_size(size_t txt_length) -> size_t {
    return static_cast<size_t>(ceil(sqrt(txt_length)));
  }

  auto chunkify(string src, size_t chunk_len) -> vector<string> {
    vector<string> chunks;
    for (size_t k = 0; k < src.size(); k += chunk_len) {
      chunks.emplace_back(src.substr(k, chunk_len));
    }
    return chunks;
  }

  auto cipher::normalize_plain_text() -> string {
    string clean = regex_replace(_plaintext, regex{ "[^A-Za-z0-9]" }, "");
    transform(clean.begin(), clean.end(), clean.begin(), ::tolower);
    return clean;
  }

  auto cipher::plain_text_segments() -> vector<string> {
    string base = normalize_plain_text();
    return chunkify(base, segment_size(base.size()));
  }

  auto cipher::cipher_text() -> string {
    return regex_replace(normalized_cipher_text(), regex{ "\\s+" }, "");
  }

  auto cipher::normalized_cipher_text() -> string {
    auto grid = plain_text_segments();
    if (grid.empty()) return "";
    stringstream final;

    for (size_t x = 0; x < grid[0].length(); ++x) {
      for (size_t y = 0; y < grid.size(); ++y) {
        final << (x < grid[y].length() ? grid[y][x] : ' ');
      }
      if (x + 1 < grid[0].length()) final << ' ';
    }

    return final.str();
  }
}
