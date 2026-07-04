enum SaddlePoints {
    static func saddlePoints(_ matrix: [[Int]]) -> [Position] {
        guard !matrix.isEmpty else { return [] }

        let rowMaxima = matrix.map { $0.max()! }
        let colMinima = matrix[0].indices.map { col in matrix.map { $0[col] }.min()! }

        return matrix.enumerated().flatMap { rowIdx, row in
            positions(in: row, at: rowIdx, rowMax: rowMaxima[rowIdx], colMinima: colMinima)
        }
    }

    private static func positions(in row: [Int], at rowIdx: Int, rowMax: Int, colMinima: [Int]) -> [Position] {
        row.enumerated().compactMap { colIdx, value in
            value == rowMax && value == colMinima[colIdx]
                ? Position(row: rowIdx + 1, column: colIdx + 1)
                : nil
        }
    }
}