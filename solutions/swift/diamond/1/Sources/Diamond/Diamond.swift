struct Diamond {
    static let alaphabet =
        ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    static func makeDiamond(letter: String) -> [String] {
        let maxPaddingWidth = alaphabet.firstIndex(of: letter)!
        let getLineWithOffset = getLineWith(maxPaddingWidth: maxPaddingWidth)
        var diamond = [String]()
        
        for index in 0...maxPaddingWidth {
            diamond.append(getLineWithOffset(index))
        }
        
        for index in stride(from: maxPaddingWidth - 1, through: 0, by: -1) {
            diamond.append(getLineWithOffset(index))
        }

        return diamond
    }

    static private func getLineWith(maxPaddingWidth: Int) -> (Int) -> String {
        return { index in
            let letter = alaphabet[index]
            let spaces = String(repeating: " ", count: maxPaddingWidth - index)
            let walls = letter + (index > 0 ? String(repeating: " ", count: (2 * index - 1)) + letter : "")

            return spaces + walls + spaces
        }
    }
}