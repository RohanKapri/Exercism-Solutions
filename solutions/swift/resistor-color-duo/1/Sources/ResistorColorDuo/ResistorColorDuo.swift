enum ResistorColorError: Error {
    case invalidColorName
}

enum ResistorColor: String, CaseIterable {
    case black, brown, red, orange, yellow, green, blue, violet, grey, white

    var value: Int {
        Self.allCases.firstIndex(of: self)!
    }
}

enum ResistorColorDuo {
    static func value(for colors: [String]) throws -> Int {
        let codes = colors.prefix(2).compactMap(ResistorColor.init(rawValue:))
        guard codes.count == 2 else {
            throw ResistorColorError.invalidColorName
        }
        
        let (tens, ones) = (codes[0], codes[1])
        return tens.value * 10 + ones.value
    }
}