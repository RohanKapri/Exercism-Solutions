#[derive(Drop, Copy, PartialEq, Debug)]
pub enum Direction {
    North,
    East,
    South,
    West,
}

#[derive(Drop)]
pub struct Robot {
    x: i32,
    y: i32,
    direction: Direction,
}

#[generate_trait]
pub impl RobotImpl of RobotTrait {
    fn new(x: i32, y: i32, d: Direction) -> Robot {
        Robot { x, y, direction: d }
    }

    #[must_use]
    fn turn_right(self: Robot) -> Robot {
        let new_direction = match self.direction {
            Direction::North => Direction::East,
            Direction::East => Direction::South,
            Direction::South => Direction::West,
            Direction::West => Direction::North,
        };
        Robot { x: self.x, y: self.y, direction: new_direction }
    }

    #[must_use]
    fn turn_left(self: Robot) -> Robot {
        let new_direction = match self.direction {
            Direction::North => Direction::West,
            Direction::West => Direction::South,
            Direction::South => Direction::East,
            Direction::East => Direction::North,
        };
        Robot { x: self.x, y: self.y, direction: new_direction }
    }

    #[must_use]
    fn advance(self: Robot) -> Robot {
        let (new_x, new_y) = match self.direction {
            Direction::North => (self.x, self.y + 1),
            Direction::South => (self.x, self.y - 1),
            Direction::East => (self.x + 1, self.y),
            Direction::West => (self.x - 1, self.y),
        };
        Robot { x: new_x, y: new_y, direction: self.direction }
    }

    #[must_use]
    fn instructions(mut self: Robot, instructions: ByteArray) -> Robot {
        let mut i = 0;
        while i < instructions.len() {
            let instruction = instructions.at(i).unwrap();
            if instruction == 'R' {
                self = self.turn_right();
            } else if instruction == 'L' {
                self = self.turn_left();
            } else if instruction == 'A' {
                self = self.advance();
            }
            // ignore unknown instructions
            i += 1;
        };
        self
    }

    fn position(self: @Robot) -> (i32, i32) {
        (*self.x, *self.y)
    }

    fn direction(self: @Robot) -> @Direction {
        self.direction
    }
}
   