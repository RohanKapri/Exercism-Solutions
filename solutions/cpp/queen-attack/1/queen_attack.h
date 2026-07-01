#ifndef QUEEN_ATTACK_H_
#define QUEEN_ATTACK_H_
#include <utility>
#include <stdexcept>
namespace queen_attack {
    
    class chess_board {
        const int board_size_ = 7;
        using position_type = std::pair<int, int>;
    public:
        chess_board() 
            : white_position_({0, 3}), black_position_({7, 3}) {}
        explicit chess_board(position_type white, position_type black)
            : white_position_(white), black_position_(black) {
            if (white_position_ == black_position_) 
                throw std::domain_error("Queen positions must be distinct!");
            if (white_position_.first > board_size_ || white_position_.first < 0 ||
                white_position_.second > board_size_ || white_position_.second < 0 ||
                black_position_.first > board_size_ || black_position_.first < 0 ||
                black_position_.second > board_size_ || black_position_.second < 0) 
                throw std::domain_error("Out of edges");
        }
        const position_type& white() const { return white_position_; }
        const position_type& black() const { return black_position_; }
        bool can_attack() const;
        operator std::string() const;
    private:
        position_type white_position_;
        position_type black_position_;
    };
} // namespace queen_attack
#endif // !QUEEN_ATTACK_H_
