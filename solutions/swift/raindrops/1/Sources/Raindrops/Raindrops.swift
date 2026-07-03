func raindrops(_ number: Int) -> String {
    let onomatopoeia = convert(number: number)
    
    return onomatopoeia.isEmpty ? String(number) : onomatopoeia
}

private let translations = [
    (value: 3, sound: "Pling"),
    (value: 5, sound: "Plang"),
    (value: 7, sound: "Plong")
]

private func convert(number: Int) -> String {
    translations
        .filter { number.isMultiple(of: $0.value) }
        .map(\.sound)
        .joined()
}