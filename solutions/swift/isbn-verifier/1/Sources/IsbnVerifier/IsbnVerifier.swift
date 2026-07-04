struct IsbnVerifier {
    static func isValid(_ isbn: String) -> Bool {
        let stripped = removeHyphens(from: isbn)
        return charactersValid(in: stripped) && sumDigits(in: stripped) % 11 == 0
    }
    
    private static func removeHyphens(from isbn: String) -> String {
        isbn.filter { $0 != "-" }
    }
    
    private static func charactersValid(in characters: String) -> Bool {
        characters.count == 10 &&
        characters.dropLast().allSatisfy(\.isNumber) &&
        (characters.last?.isNumber == true || characters.last == "X")
    }
    
    private static func sumDigits(in stripped: String) -> Int {
        stripped.reversed()
            .enumerated()
            .map { (index, character) in isbnValue(of: character) * (index + 1) }
            .reduce(0, +)
    }
    
    private static func isbnValue(of character: Character) -> Int {
        character == "X" ? 10 : character.wholeNumberValue ?? 0
    }
}