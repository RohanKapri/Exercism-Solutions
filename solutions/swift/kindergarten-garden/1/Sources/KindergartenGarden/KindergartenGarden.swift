enum Plant: Character {
    case grass = "G"
    case clover = "C"
    case radishes = "R"
    case violets = "V"
}

struct Garden {
    private let rows: [String]

    private static let children = [
        "Alice", "Bob", "Charlie", "David",
        "Eve", "Fred", "Ginny", "Harriet",
        "Ileana", "Joseph", "Kincaid", "Larry"
    ]

    init(_ diagram: String) {
        rows = diagram.split(separator: "\n").map(String.init)
    }

    func plantsForChild(_ child: String) -> [Plant] {
        guard let childIndex = Garden.children.firstIndex(of: child) else {
            return []
        }

        return Garden.plants(from: rows, in: childIndex)
    }

    private static func plants(from rows: [String], in childIndex: Int) -> [Plant] {
        rows.flatMap { row in
            let i = row.index(row.startIndex, offsetBy: childIndex * 2)
            let j = row.index(after: i)

            return [row[i], row[j]].compactMap { Plant(rawValue: $0) }
        }
    }
}