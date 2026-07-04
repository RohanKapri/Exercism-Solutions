struct AtbashCipher {
    private static let chunkSize = 5

    static func encode(_ phrase: String) -> String {
        cipher(phrase.lowercased()).chunk(by: chunkSize)
    }

    static func decode(_ phrase: String) -> String {
        cipher(phrase)
    }

    private static func cipher(_ phrase: String) -> String {
        alphanumeric(from: phrase).map { char in
            char.isNumber ? String(char) : transpose(character: char)
        }.joined()
    }

    private static func alphanumeric(from text: String) -> String {
        text.replacing(#/[^a-z0-9]/#, with: "")
    }

    private static func transpose(character: Character) -> String {
        let ascii = Character("a").asciiValue! + Character("z").asciiValue! - character.asciiValue!
        return String(UnicodeScalar(ascii))
    }
}

fileprivate extension String {
    func chunk(by size: Int) -> String {
        stride(from: 0, to: count, by: size).map { i in
            let start = index(startIndex, offsetBy: i)
            let end = index(start, offsetBy: size, limitedBy: endIndex) ?? endIndex

            return String(self[start..<end])
        }.joined(separator: " ")
    }
}