enum ResistorColorError: Error {
    case invalidColorName
}

enum ResistorColor: String, CaseIterable {
    case black, brown, red, orange, yellow, green, blue, violet, grey, white

    static let colors = allCases.map(\.rawValue)

    static func colorCode(for name: String) throws -> Int {
        guard let color = ResistorColor(rawValue: name),
              let index = allCases.firstIndex(of: color) else {
            throw ResistorColorError.invalidColorName
        }

        return index
    }
}