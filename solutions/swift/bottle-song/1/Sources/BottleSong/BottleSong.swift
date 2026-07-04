struct BottleSong {
    private static let quantityConversion = ["no", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"]
    private let totalBottles: Int

    init(bottles: Int) {
        self.totalBottles = bottles
    }

    func song(takedown: Int) -> [String] {
        let stop = totalBottles - takedown

        return stride(from: totalBottles, to: stop, by: -1).flatMap { currentCount in
            let remainingCount = currentCount - 1
            let verse = Self.verse(for: currentCount, remaining: remainingCount)

            return remainingCount == stop ? verse : verse + [""]
        }
    }

    private static func verse(for currentCount: Int, remaining remainingCount: Int) -> [String] {
        let current = Self.quantityConversion[currentCount].capitalize()

        return [
            "\(current) green \(pluralize(word: "bottle", quantity: currentCount)) hanging on the wall,",
            "\(current) green \(pluralize(word: "bottle", quantity: currentCount)) hanging on the wall,",
            "And if one green bottle should accidentally fall,",
            "There'll be \(Self.quantityConversion[remainingCount]) green \(pluralize(word: "bottle", quantity: remainingCount)) hanging on the wall."
        ]
    }

    private static func pluralize(word: String, quantity: Int) -> String {
        quantity != 1 ? word + "s" : word
    }
}

fileprivate extension String {
    func capitalize() -> String {
        prefix(1).uppercased() + dropFirst()
    }
}
