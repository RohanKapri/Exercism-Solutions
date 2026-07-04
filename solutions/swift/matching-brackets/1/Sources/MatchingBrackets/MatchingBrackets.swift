struct MatchingBrackets {
    private static let pairs: [Character: Character] = ["(": ")", "[": "]", "{": "}"]

    static func paired(text: String) -> Bool {
        var stack = [Character]()

        for char in text {
            if pairs[char] != nil {
                stack.append(char)
            } else if pairs.values.contains(char) {
                guard let top = stack.last, pairs[top] == char else {
                    return false
                }

                stack.removeLast()
            }
        }

        return stack.isEmpty
    }
}