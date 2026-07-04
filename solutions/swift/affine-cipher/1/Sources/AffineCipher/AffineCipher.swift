struct AffineCipher {
    func encode(_ phrase: String, keyA: Int, keyB: Int) throws -> String {
        guard let _ = modularInverse(of: keyA) else {
            throw AffineCipherError.keysNotCoprime
        }

        let preparedInput = prepare(input: phrase)

        return shiftCharacters(in: preparedInput) { index in
            (keyA * index + keyB) % alphabet.count
        }.chunk(by: 5)
    }

    func decode(_ phrase: String, keyA: Int, keyB: Int) throws -> String {
        guard let inverse = modularInverse(of: keyA) else {
            throw AffineCipherError.keysNotCoprime
        }

        let preparedInput = prepare(input: phrase)

        return shiftCharacters(in: preparedInput) { index in
            (inverse * (index - keyB)).mod(alphabet.count)
        }
    }

    private let alphabet = Array("abcdefghijklmnopqrstuvwxyz")

    private func modularInverse(of a: Int) -> Int? {
        (1...alphabet.count).first(where: { a * $0 % alphabet.count == 1})
    }

    private func prepare(input: String) -> String {
        input.lowercased().replacing(#/[^0-9a-z]/#, with: "")
    }

    private func shiftCharacters(in text: String, with shift: (Int) -> Int) -> String {
        text.map { character in
            if character.isNumber {
                return String(character)
            }

            let index = alphabet.firstIndex(of: character)!
            let cipherIndex = shift(index)

            return String(alphabet[cipherIndex])
        }.joined()
    }
}

fileprivate extension String {
    func chunk(by size: Int) -> String {
        stride(from: 0, to: self.count, by: size).map { i -> String in
            let start = index(startIndex, offsetBy: i)
            let end = index(start, offsetBy: size, limitedBy: self.endIndex) ?? self.endIndex

            return String(self[start..<end])
        }.joined(separator: " ")
    }
}

fileprivate extension Int {
    func mod(_ divisor: Int) -> Int {
        precondition(divisor > 0, "modulus must be positive")
        let remainder = self % divisor

        return remainder >= 0 ? remainder : remainder + divisor
    }
}