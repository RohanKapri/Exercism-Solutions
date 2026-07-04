struct Cipher {
    private enum Direction: Int {
        case encode = 1
        case decode = -1
    }

    private static let keySize = 100
    private static let letterCount = 26
    private static let aValue = Int(Character("a").asciiValue!)

    private static func letterIndex(of character: Character) -> Int {
        Int(character.asciiValue!) - aValue
    }

    private static func letter(at index: Int) -> Character {
        Character(UnicodeScalar(aValue + index)!)
    }

    private static func shift(_ textIndex: Int, by keyIndex: Int, direction: Direction) -> Int {
        (textIndex + direction.rawValue * keyIndex + letterCount) % letterCount
    }
    
    let key: String
    
    init() {
        self.key = Self.randomKey()
    }
    
    init?(key: String) {
        guard Self.isValid(key: key) else {
            return nil
        }
        
        self.key = key
    }
    
    func encode(_ text: String) -> String {
        Self.shiftCharacters(in: text, using: key, direction: .encode)
    }

    func decode(_ text: String) -> String {
        Self.shiftCharacters(in: text, using: key, direction: .decode)
    }

    private static func shiftCharacters(in text: String, using key: String, direction: Direction) -> String {
        let keyArray = Array(key)

        let characters = text.enumerated().map { index, textCharacter in
            let keyCharacter = keyArray[index % keyArray.count]
            let shiftedIndex = shift(letterIndex(of: textCharacter), by: letterIndex(of: keyCharacter), direction: direction)

            return letter(at: shiftedIndex)
        }

        return String(characters)
    }
    
    private static func randomKey() -> String {
        let characters = (0..<keySize).map { _ in letter(at: Int.random(in: 0..<letterCount)) }

        return String(characters)
    }

    private static func isValid(key: String) -> Bool {
        !key.isEmpty && key.allSatisfy { $0.isLowercase && $0.isASCII }
    }
}