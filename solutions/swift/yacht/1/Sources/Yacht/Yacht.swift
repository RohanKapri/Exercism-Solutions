func score(_ scores: [Int], category: YachtCategory) -> Int {
    switch category {
    case .ones:
        score(number: 1, in: scores)
    case .twos:
        score(number: 2, in: scores)
    case .threes:
        score(number: 3, in: scores)
    case .fours:
        score(number: 4, in: scores)
    case .fives:
        score(number: 5, in: scores)
    case .sixes:
        score(number: 6, in: scores)
    case .fullHouse:
        scoreFullHouse(in: scores)
    case .fourOfAKind:
        scoreFourOfAKind(in: scores)
    case .littleStraight:
        score(straight: littleStraight, in: scores)
    case .bigStraight:
        score(straight: bigStraight, in: scores)
    case .choice:
        scores.reduce(0, +)
    case .yacht:
        scoreYacht(in: scores)
    }
}

private func score(number: Int, in scores: [Int]) -> Int {
    scores.filter { $0 == number }.reduce(0, +)
}

private func scoreFullHouse(in scores: [Int]) -> Int {
    isFullHouse(scores) ? scores.reduce(0, +) : 0
}

private func isFullHouse(_ scores: [Int]) -> Bool {
    group(scores: scores).allSatisfy { $0.value == 2 || $0.value == 3 }
}

private func scoreFourOfAKind(in scores: [Int]) -> Int {
    (fourOfAKindValue(in: scores) ?? 0) * 4
}

private func fourOfAKindValue(in scores: [Int]) -> Int? {
    group(scores: scores).first(where: { $0.value >= 4 })?.key
}

private func group(scores: [Int]) -> [Int: Int] {
    scores.reduce(into: [Int: Int]()) { $0[$1, default: 0] += 1 }
}

private let littleStraight = [1, 2, 3, 4, 5]
private let bigStraight = [2, 3, 4, 5, 6]

func score(straight sequence: [Int], in scores: [Int]) -> Int {
    sequence == scores.sorted() ? 30 : 0
}

private func scoreYacht(in scores: [Int]) -> Int {
    isYacht(scores) ? 50 : 0
}

private func isYacht(_ scores: [Int]) -> Bool {
    scores.allSatisfy { $0 == scores[0] }
}