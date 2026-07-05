public type Position record {
    int x;
    int y;
};

public enum Direction {
    NORTH, EAST, SOUTH, WEST
}

public type Robot record {|
    Position position;
    Direction direction;
|};

public function newRobot(Position position = {x: 0, y: 0}, Direction direction = NORTH) returns Robot {
    return {
        position: position,
        direction: direction
    };
}

public function move(Robot robot, string instructionSeq) returns Robot {
    string[] instructions = from string s in instructionSeq select s;

    foreach string instruction in instructions {
        if (instruction == "R") {
            robot.direction = turnRight(robot.direction);
        } else if (instruction == "L") {
            robot.direction = turnLeft(robot.direction);
        } else if (instruction == "A") {
            match robot.direction {
                NORTH => { robot.position.y += 1; }
                SOUTH => { robot.position.y -= 1; }
                EAST => { robot.position.x += 1; }
                WEST => { robot.position.x -= 1; }
            }
        }
    }

    return robot;
}

function turnRight(Direction direction) returns Direction {
    if (direction == NORTH) {
        return EAST;
    } else if (direction == EAST) {
        return SOUTH;
    } else if (direction == SOUTH) {
        return WEST;
    } else {
        return NORTH;
    }
}

function turnLeft(Direction direction) returns Direction {
    if (direction == NORTH) {
        return WEST;
    } else if (direction == WEST) {
        return SOUTH;
    } else if (direction == SOUTH) {
        return EAST;
    } else {
        return NORTH;
    }
}