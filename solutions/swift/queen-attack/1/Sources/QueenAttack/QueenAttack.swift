enum QueenError: Error {
    case inValidRow
    case inValidColumn
}

struct Queen {
    let row: Int
    let column: Int

    private static let validRange = 0...7

    init(row: Int, column: Int) throws {
        guard Self.validRange ~= row else {
            throw QueenError.inValidRow
        }

        guard Self.validRange ~= column else {
            throw QueenError.inValidColumn
        }

        self.row = row
        self.column = column
    }

    func canAttack(other: Queen) -> Bool {
        sharesRow(with: other) || sharesColumn(with: other) || sharesDiagonal(with: other)
    }

    private func sharesRow(with other: Queen) -> Bool {
        row == other.row
    }

    private func sharesColumn(with other: Queen) -> Bool {
        column == other.column
    }

    private func sharesDiagonal(with other: Queen) -> Bool {
        abs(row - other.row) == abs(column - other.column)
    }
}