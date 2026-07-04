enum Direction {
    case north
    case east
    case south
    case west
}

class SimulatedRobot {
    private var x: Int
    private var y: Int
    private var bearing: Direction

    init(x: Int, y: Int, bearing: Direction) {
        self.x = x
        self.y = y
        self.bearing = bearing
    }

    var state: (x: Int, y: Int, bearing: Direction) {
        (x: x, y: y, bearing: bearing)
    }

    func move(commands: String) {
        commands.forEach { character in
            switch character {
            case "L": turnLeft()
            case "R": turnRight()
            case "A": advance()
            default:  break
            }
        }
    }

    private func turnRight() {
        switch bearing {
        case .north: bearing = .east
        case .east:  bearing = .south
        case .south: bearing = .west
        case .west:  bearing = .north
        }
    }

    private func turnLeft() {
        switch bearing {
        case .north: bearing = .west
        case .east:  bearing = .north
        case .south: bearing = .east
        case .west:  bearing = .south
        }
    }

    private func advance() {
        switch bearing {
        case .north: y += 1
        case .east:  x += 1
        case .south: y -= 1
        case .west:  x -= 1
        }
    }
}