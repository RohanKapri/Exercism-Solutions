// Dedicated to Shree DR.MDD

#include "queen_attack.h"
#include <stdlib.h>

int valid_position(uint8_t pos) {
    return pos < 8;
}

attack_status_t can_attack(position_t piece1, position_t piece2) {
    if (!valid_position(piece1.row) || !valid_position(piece1.column)) {return INVALID_POSITION; }
    if (!valid_position(piece2.row) || !valid_position(piece2.column)) {return INVALID_POSITION; }

    int deltaX = abs(piece1.column - piece2.column);
    int deltaY = abs(piece1.row - piece2.row);

    if (deltaX == 0 && deltaY == 0) {return INVALID_POSITION; }
    if (deltaX == deltaY) {return CAN_ATTACK; }
    if (piece2.row == piece1.row) {return CAN_ATTACK; }
    if (piece2.column == piece1.column) {return CAN_ATTACK;}

    return CAN_NOT_ATTACK;
}
