private let complements: [Character: Character] = ["G": "C", "C": "G", "T": "A", "A": "U"]

func toRna(_ strand: String) -> String {
    String(strand.compactMap { complements[$0] })
}