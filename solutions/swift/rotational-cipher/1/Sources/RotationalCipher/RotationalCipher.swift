func rotateCipher(_ input: String, shift: Int) -> String {
    String(input.map { encode(char: $0, shift: shift) })
}

private let alphabet = Array("abcdefghijklmnopqrstuvwxyz")

private func encode(char: Character, shift: Int) -> Character {
    guard let index = alphabet.firstIndex(of: Character(char.lowercased())) else {
        return char
    }

    let rotatedCharacter = alphabet[(index + shift) % alphabet.count]

    return char.isUppercase ? Character(rotatedCharacter.uppercased()) : rotatedCharacter
}