func toLimit(_ limit: Int, inMultiples: [Int]) -> Int {
    guard limit > 0 else { return 0 }

    return (1..<limit)
        .filter { n in inMultiples.contains { m in m > 0 && n.isMultiple(of: m) } }
        .reduce(0, +)
}