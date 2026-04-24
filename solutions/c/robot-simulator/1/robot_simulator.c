// Dedicated to Shree DR.MDD

#include "robot_simulator.h"

robot_status_t robot_create(robot_direction_t way, int xx, int yy){
    robot_status_t bot;
    bot.direction = way;
    bot.position.x = xx;
    bot.position.y = yy;
    return bot;
}

void robot_move(robot_status_t *bot, const char *steps) {
    for (const char *p = steps; *p != '\0'; ++p) {
        switch (*p) {
            case 'R':
                bot->direction = (bot->direction + 1) % DIRECTION_MAX;
                break;
            case 'L':
                bot->direction = (bot->direction + DIRECTION_MAX - 1) % DIRECTION_MAX;
                break;
            case 'A':
                if (bot->direction == DIRECTION_NORTH) {
                    bot->position.y++;
                } else if (bot->direction == DIRECTION_EAST) {
                    bot->position.x++;
                } else if (bot->direction == DIRECTION_SOUTH) {
                    bot->position.y--;
                } else if (bot->direction == DIRECTION_WEST) {
                    bot->position.x--;
                }
                break;
            default:
                break;
        }
    }
}
