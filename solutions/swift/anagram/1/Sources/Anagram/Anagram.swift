class Anagram {
    let word: String

    init(word: String) {
        self.word = word
    }

    func match(_ words: [String]) -> [String] {
        words.filter { $0.lowercased() != word.lowercased() && $0.lowercased().sorted() == word.lowercased().sorted() }
    }
}