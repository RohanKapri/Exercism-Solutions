enum ResistorColorError: Error {
    case invalidColorName
}

enum ResistorColor: String, CaseIterable {
    case black, brown, red, orange, yellow, green, blue, violet, grey, white

    static func colorCode(for name: String) throws -> Int {
        guard let resistorColor = ResistorColor(rawValue: name) else {
            throw ResistorColorError.invalidColorName
        }

        return Self.allCases.firstIndex(of: resistorColor)!
    }
}

struct ResistorColorTrio {
    static func label(for colors: [String]) throws -> String {
        let numericValue = try numericValue(from: colors)
        let (value, unit) = scaled(numericValue)

        return "\(value) \(unit)"
    }

    private static let multipliers = [1, 10, 100, 1_000, 10_000, 100_000, 1_000_000, 10_000_000, 100_000_000, 1_000_000_000]

    private static func numericValue(from colors: [String]) throws -> Int {
        let resistorColors = try colors.map { try ResistorColor.colorCode(for: $0) }

        return (resistorColors[0] * 10 + resistorColors[1]) * Self.multipliers[resistorColors[2]]
    }

    private static let units = ["ohms", "kiloohms", "megaohms", "gigaohms"]
    private static func scaled(_ value: Int) -> (value: Int, unit: String) {
        guard value > 0 else {
            return (value: 0, unit: "ohms")
        }

        var resistance = value
        var multiple = 0

        while resistance % 1000 == 0 {
            resistance /= 1000
            multiple += 1
        }

        return (value: resistance, unit: units[multiple])
    }
}