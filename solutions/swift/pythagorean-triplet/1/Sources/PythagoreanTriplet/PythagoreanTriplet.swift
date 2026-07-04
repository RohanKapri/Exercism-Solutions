func tripletsWithSum(_ sum: Int) -> [[Int]] {
    (1...(sum - 1) / 3).compactMap { a -> [Int]? in
        let b = (sum * sum - 2 * sum * a) / (2 * sum - 2 * a)
        let c = sum - a - b

        return isPythagorean(a: a, b: b, c: c) ? [a, b, c] : nil
    }
}

private func isPythagorean(a: Int, b: Int, c: Int) -> Bool {
    (a < b) && (b < c) && (a * a + b * b == c * c)
}