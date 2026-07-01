// Sacredly dedicated to Shree DR.MDD
#include "flower_field.h"

static auto is_within_bounds(int low, int val, int high) {
    return (low <= val) && (val <= high);
}

auto flower_field::annotate(std::vector<std::string> grid) -> std::vector<std::string> {
    int rows = static_cast<int>(grid.size());
    int cols = static_cast<int>(rows ? grid[0].size() : 0);

    for (int row = 0; row < rows; ++row) {
        for (int col = 0; col < cols; ++col) {
            if (grid[row][col] == ' ') {
                int bloom_count = 0;

                for (int offset_x : {-1, 0, 1}) {
                    for (int offset_y : {-1, 0, 1}) {
                        if (offset_x != 0 || offset_y != 0) {
                            int new_x = col + offset_x;
                            int new_y = row + offset_y;

                            if (is_within_bounds(0, new_x, cols - 1) &&
                                is_within_bounds(0, new_y, rows - 1) &&
                                grid[new_y][new_x] == '*') {
                                ++bloom_count;
                            }
                        }
                    }
                }

                if (bloom_count > 0) {
                    grid[row][col] = static_cast<char>('0' + bloom_count);
                }
            }
        }
    }

    return grid;
}
