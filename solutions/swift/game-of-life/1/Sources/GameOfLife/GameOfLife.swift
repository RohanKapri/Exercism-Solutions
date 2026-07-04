func tick(_ matrix: [[Int]]) -> [[Int]] {
  guard !matrix.isEmpty else {
    return []
  }

  let rows = matrix.count
  let cols = matrix[0].count
  let neighborOffsets = [
    (-1, -1), (-1, 0), (-1, 1),
    (0, -1), (0, 1),
    (1, -1), (1, 0), (1, 1),
  ]

  return (0..<rows).map { row in
    (0..<cols).map { col in
      let liveNeighbors = neighborOffsets.count { (dr, dc) in
        let r = row + dr
        let c = col + dc

        return (r >= 0 && r < rows && c >= 0 && c < cols) && matrix[r][c] == 1
      }

      let isAlive = matrix[row][col] == 1

      return (isAlive && liveNeighbors == 2) || liveNeighbors == 3 ? 1 : 0
    }
  }
}