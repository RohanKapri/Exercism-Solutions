struct Proverb {
    let verses: [String]

    init(_ wants: [String]) {
        verses = Self.buildVerses(for: wants)
    }

    func recite() -> String {
        verses.joined(separator: "\n")
    }

    private static func buildVerses(for wants: [String]) -> [String] {
        guard let first = wants.first else {
            return []
        }

        let mainVerses = zip(wants, wants.dropFirst()).map { (current, next) in
            "For want of a \(current) the \(next) was lost."
        }

        return mainVerses + ["And all for the want of a \(first)."]
    }
}