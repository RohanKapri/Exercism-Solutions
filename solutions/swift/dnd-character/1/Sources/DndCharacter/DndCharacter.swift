func modifier(_ score: Int) -> Int {
    let scoreModifier: Double = Double(score - 10) / 2.0
    return Int(scoreModifier.rounded(.down))
}

func ability() -> Int {
    let rolld6: () -> Int = { Int.random(in: 1...6) }
    let diceRolls: [Int] = (1...4).map { _ in rolld6() }
    return diceRolls.sorted().dropFirst().reduce(0, +)
}

struct DndCharacter {
    let hitpoints: Int
    let strength: Int
    let dexterity: Int
    let constitution: Int
    let intelligence: Int
    let wisdom: Int
    let charisma: Int

    init() {
        self.strength = ability()
        self.dexterity = ability()
        self.constitution = ability()
        self.intelligence = ability()
        self.wisdom = ability()
        self.charisma = ability()
        self.hitpoints = 10 + modifier(constitution)
    }
}