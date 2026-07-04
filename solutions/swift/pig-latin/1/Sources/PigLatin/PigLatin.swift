struct PigLatin {
    private static let vowels: Set<Character> = ["a", "e", "i", "o", "u"]

    static func translate(_ input: String) -> String {
        input.split(separator: " ").map { word in
            translateWord(word: String(word))
        }.joined(separator: " ")
    }
    
    private static func translateWord(word: String) -> String {
        if startsWithVowelSound(word: word) {
            return word + "ay"
        }

        let splitIndex = findSplitIndex(in: word)

        return rotate(word, at: splitIndex) + "ay"
    }

    private static func startsWithVowelSound(word: String) -> Bool {
        if let first = word.first, vowels.contains(first) { return true }

        return word.hasPrefix("xr") || word.hasPrefix("yt")
    }

    private static func findSplitIndex(in word: String) -> String.Index {
        var index = word.startIndex

        while index < word.endIndex {
            let char = word[index]

            if vowels.contains(char) {
                if char == "u", index > word.startIndex, word[word.index(before: index)] == "q" {
                    return word.index(after: index)
                }

                return index
            }

            if char == "y", index != word.startIndex {
                return index
            }

            index = word.index(after: index)
        }

        return word.startIndex
    }
    
    private static func rotate(_ word: String, at index: String.Index) -> String {
        String(word[index...]) + String(word[..<index])
    }
}