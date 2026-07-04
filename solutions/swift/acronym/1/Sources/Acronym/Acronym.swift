struct Acronym {
    static func abbreviate(_ name: String) -> String {
        name.replacing(#/[-_,]/#, with: " ")
            .split(separator: " ")
            .map { String($0.prefix(1)).uppercased() }
            .joined()
    }
}