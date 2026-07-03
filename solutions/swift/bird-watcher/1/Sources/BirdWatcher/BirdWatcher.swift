func totalBirdCount(_ birdsPerDay: [Int]) -> Int {
    birdsPerDay.reduce(0, +)
}

func birdsInWeek(_ birdsPerDay: [Int], weekNumber: Int) -> Int {
    let start = (weekNumber - 1) * 7
    return totalBirdCount(Array(birdsPerDay[start..<start + 7]))
}

func fixBirdCountLog(_ birdsPerDay: [Int]) -> [Int] {
    birdsPerDay.enumerated().map { index, count in
        index.isMultiple(of: 2) ? count + 1 : count
    }
}