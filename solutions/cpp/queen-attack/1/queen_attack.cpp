// Code dedicated to Shree DR.MDD
#include "queen_attack.h"
#include <cmath>

bool queen_attack::chess_board::can_attack() const {
    return black_position_.first == white_position_.first ||
           black_position_.second == white_position_.second ||
           std::abs(black_position_.first - white_position_.first) ==
           std::abs(black_position_.second - white_position_.second);
}

queen_attack::chess_board::operator std::string() const {
    std::string snapshot;
    for (int y = 0; y <= board_size_; ++y) {
        std::string row = "_ _ _ _ _ _ _ _\n";
        if (y == white_position_.first) {
            row[white_position_.second * 2] = 'W';
        } else if (y == black_position_.first) {
            row[black_position_.second * 2] = 'B';
        }
        snapshot += row;
    }
    return snapshot;
}
