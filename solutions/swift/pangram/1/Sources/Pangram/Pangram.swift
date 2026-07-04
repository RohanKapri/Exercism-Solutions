func isPangram(_ phrase: String) -> Bool {
    Set(phrase.lowercased().filter(\.isLetter)).isSuperset(of: "abcdefghijklmnopqrstuvwxyz")
}