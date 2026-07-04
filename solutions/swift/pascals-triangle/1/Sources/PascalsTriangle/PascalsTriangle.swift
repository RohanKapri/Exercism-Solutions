func pascalsTriangle(rows: Int) -> [[Int]] {
    guard rows > 0 else {
        return []
    }

    return (1..<rows).reduce(into: [[1]]) { triangle, _ in
        let prev = triangle.last!
        triangle.append([1] + zip(prev, prev.dropFirst()).map(+) + [1])
    }
}