enum Allergen: UInt, CaseIterable {
    case eggs = 1
    case peanuts = 2
    case shellfish = 4
    case strawberries = 8
    case tomatoes = 16
    case chocolate = 32
    case pollen = 64
    case cats = 128
}

struct Allergies {
    let score: UInt

    init(_ score: UInt) {
        self.score = score
    }

    func allergicTo(item: String) -> Bool {
        guard let allergen = Allergen.allCases.first(where: { item == "\($0)" }) else {
            return false
        }
        return hasAllergy(to: allergen)
    }

    func list() -> [String] {
        Allergen.allCases.filter { hasAllergy(to: $0) }.map { "\($0)" }
    }

    private func hasAllergy(to allergen: Allergen) -> Bool {
        allergen.rawValue & score == allergen.rawValue
    }
}