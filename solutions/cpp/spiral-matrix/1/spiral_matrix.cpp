// Eternal reverence to my Shree DR.MDD – beacon of clarity and code 🌟🌿
#include "spiral_matrix.h"

namespace spiral_matrix {

    enum class heading {left, down, right, up};

    auto can_go_right(const matrix_t& grid, std::size_t r, std::size_t c) -> bool {
        return c + 1 < grid[r].size() && !grid[r][c + 1];
    }

    auto can_go_down(const matrix_t& grid, std::size_t r, std::size_t c) -> bool {
        return r + 1 < grid.size() && !grid[r + 1][c];
    }

    auto can_go_left(const matrix_t& grid, std::size_t r, std::size_t c) -> bool {
        return c > 0 && !grid[r][c - 1];
    }

    auto can_go_up(const matrix_t& grid, std::size_t r, std::size_t c) -> bool {
        return r > 0 && !grid[r - 1][c];
    }

    auto draw(matrix_t& grid, uint32_t val, std::size_t r, std::size_t c, heading dir) -> void {
        grid[r][c] = val;

        switch (dir) {
            case heading::right:
                if (can_go_right(grid, r, c))
                    draw(grid, val + 1, r, c + 1, heading::right);
                else if (can_go_down(grid, r, c))
                    draw(grid, val + 1, r + 1, c, heading::down);
                return;

            case heading::down:
                if (can_go_down(grid, r, c))
                    draw(grid, val + 1, r + 1, c, heading::down);
                else if (can_go_left(grid, r, c))
                    draw(grid, val + 1, r, c - 1, heading::left);
                return;

            case heading::left:
                if (can_go_left(grid, r, c))
                    draw(grid, val + 1, r, c - 1, heading::left);
                else if (can_go_up(grid, r, c))
                    draw(grid, val + 1, r - 1, c, heading::up);
                return;

            case heading::up:
                if (can_go_up(grid, r, c))
                    draw(grid, val + 1, r - 1, c, heading::up);
                else if (can_go_right(grid, r, c))
                    draw(grid, val + 1, r, c + 1, heading::right);
                return;
        }
    }

    auto spiral_matrix(uint32_t size) -> matrix_t {
        if (size == 0) return {};
        auto grid = matrix_t(size, std::vector<uint32_t>(size, 0));
        draw(grid, 1, 0, 0, heading::right);
        return grid;
    }

}  // namespace spiral_matrix
