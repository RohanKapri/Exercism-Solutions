func isIsogram(_ word: String) -> Bool {
    let letters = word.lowercased().filter(\.isLetter)
    return letters.count == Set(letters).count
}