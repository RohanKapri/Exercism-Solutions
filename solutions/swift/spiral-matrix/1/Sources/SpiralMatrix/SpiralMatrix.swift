typealias Position = (x: Int, y: Int)
typealias Direction = (dx: Int, dy: Int)

func spiralMatrix(size: Int) -> [[Int]] {
    guard size > 0 else {
        return []
    }

    var matrix = emptyMatrix(of: size)
    var position = (x: 0, y: 0)
    var direction = (dx: -1, dy: 0)

    for cellNumber in 1...(size * size) {
        matrix[position.x][position.y] = cellNumber

        if shouldTurn(matrix: matrix, at: position, in: direction) {
            direction = turn(direction: direction)
        }

        position = nextPosition(from: position, in: direction)
    }

    return matrix
}

private let unvisitedValue = -1

private func emptyMatrix(of size: Int) -> [[Int]] {
    Array(repeating: Array(repeating: unvisitedValue, count: size), count: size)
}

private func shouldTurn(matrix: [[Int]], at position: Position, in direction: Direction) -> Bool {
    let next = nextPosition(from: position, in: direction)
    let size = matrix.count

    let outOfBounds = next.x < 0 || next.x >= size || next.y < 0 || next.y >= size
    let visited = !outOfBounds && matrix[next.x][next.y] != unvisitedValue

    return outOfBounds || visited
}

private func turn(direction: Direction) -> Direction {
    (dx: direction.dy, dy: -direction.dx)
}

private func nextPosition(from position: Position, in direction: Direction) -> Position {
    (x: position.x + direction.dx, y: position.y + direction.dy)
}