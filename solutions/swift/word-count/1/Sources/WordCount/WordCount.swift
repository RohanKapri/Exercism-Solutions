struct WordCount {
    private let words: [String]

    init(words input: String) {
        words = Self.parseWords(from: input)
    }

    func count() -> [String: Int] {
        words.reduce(into: [String: Int]()) { counts, word in
            counts[word, default: 0] += 1
        }
    }

    private static func parseWords(from input: String) -> [String] {
        input.ranges(of: #/\b[A-Za-z\d]+('[A-Za-z\d]+)?\b/#).map { range in
            input[range].lowercased()
        }
    }
}