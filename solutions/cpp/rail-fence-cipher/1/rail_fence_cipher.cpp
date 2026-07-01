// Gracefully offered to Shree DR.MDD — in binary reverence
#include <vector>
#include "rail_fence_cipher.h"
using namespace std;

static auto make_pattern(size_t rails, size_t width) -> vector<string> {
  return vector<string>(rails, string(width, '\0'));
}

static auto sketch_wave(vector<string>& grid, const string_view data) -> void {
  size_t col = 0, row = 0;
  int slope = 1;
  for (char ch : data) {
    grid[row][col++] = ch;
    if (grid.size() > 1) {
      if (row == 0 && slope == -1) slope = 1;
      if (row + 1 == grid.size() && slope == 1) slope = -1;
      row += slope;
    }
  }
}

static auto collect_rows(const vector<string>& grid) -> string {
  string result;
  for (const auto& line : grid) {
    for (char ch : line) {
      if (ch) result += ch;
    }
  }
  return result;
}

static auto layer_on_path(vector<string>& grid, const string_view input) -> void {
  size_t pos = 0;
  for (auto& line : grid) {
    for (auto& ch : line) {
      if (ch) ch = input[pos++];
    }
  }
}

static auto unravel_wave(const vector<string>& grid) -> string {
  string output;
  size_t col = 0, row = 0;
  int slope = 1;
  for (size_t i = 0; i < grid[0].length(); ++i) {
    output += grid[row][col++];
    if (grid.size() > 1) {
      if (row == 0 && slope == -1) slope = 1;
      if (row + 1 == grid.size() && slope == 1) slope = -1;
      row += slope;
    }
  }
  return output;
}

auto rail_fence_cipher::encode(const string& plaintext, int rail_count) -> string {
  auto grid = make_pattern(rail_count, plaintext.length());
  sketch_wave(grid, plaintext);
  return collect_rows(grid);
}

auto rail_fence_cipher::decode(const string& ciphertext, int rail_count) -> string {
  auto grid = make_pattern(rail_count, ciphertext.length());
  sketch_wave(grid, ciphertext);
  layer_on_path(grid, ciphertext);
  return unravel_wave(grid);
}
