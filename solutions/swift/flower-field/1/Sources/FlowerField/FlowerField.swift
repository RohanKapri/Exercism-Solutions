struct Board {
    private typealias Square = (column: Int, row: Int)
    private let flower: Character = "*"
    private let board: [[Character]]

    init(_ input: [String]) {
        board = input.map { Array($0) }
    }

    func transform() -> [String] {
        board.enumerated().map { row, chars in
            let transformed = chars.enumerated().map { column, char -> Character in
                guard char != flower else { return char }

                let count = flowerCount(for: (column: column, row: row))

                return count > 0 ? Character("\(count)") : " "
            }

            return String(transformed)
        }
    }

    private static let neighborOffsets = [
        (-1, -1), (-1, 0), (-1, 1),
        ( 0, -1),          ( 0, 1),
        ( 1, -1), ( 1, 0), ( 1, 1),
    ]

    private func flowerCount(for square: Square) -> Int {
        let (column, row) = square
        let rows = board.count
        let columns = board[0].count

        return Self.neighborOffsets.count { (dr, dc) in
            let r = row + dr
            let c = column + dc

            return r >= 0 && r < rows && c >= 0 && c < columns
                && isFlowerContained(in: (column: c, row: r))
        }
    }

    private func isFlowerContained(in square: Square) -> Bool {
        board[square.row][square.column] == flower
    }
}