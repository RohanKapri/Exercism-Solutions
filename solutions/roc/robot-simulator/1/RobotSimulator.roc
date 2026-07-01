module [create, move]

Direction : [North, East, South, West]
Robot : { x : I64, y : I64, direction : Direction }

create : { x ?? I64, y ?? I64, direction ?? Direction } -> Robot
create = |{ x ?? 0, y ?? 0, direction ?? North }|
    { x, y, direction }

move : Robot, Str -> Robot
move = |robot, instructions|
    bytes = Str.to_utf8 instructions
    List.walk bytes robot processInstruction

processInstruction : Robot, U8 -> Robot
processInstruction = |robot, instruction|
    when instruction is
        'A' -> advance(robot)
        'L' -> turnLeft(robot)
        'R' -> turnRight(robot)
        _ -> robot

advance : Robot -> Robot
advance = |robot|
    when robot.direction is
        North -> { robot & y: robot.y + 1 }
        East -> { robot & x: robot.x + 1 }
        South -> { robot & y: robot.y - 1 }
        West -> { robot & x: robot.x - 1 }

turnLeft : Robot -> Robot
turnLeft = |robot|
    { robot & direction: previousDirection(robot.direction) }

turnRight : Robot -> Robot
turnRight = |robot|
    { robot & direction: nextDirection(robot.direction) }

previousDirection : Direction -> Direction
previousDirection = |direction|
    when direction is
        North -> West
        West -> South
        South -> East
        East -> North

nextDirection : Direction -> Direction
nextDirection = |direction|
    when direction is
        North -> East
        East -> South
        South -> West
        West -> North
    