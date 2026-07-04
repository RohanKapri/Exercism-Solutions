struct Transpose {
    static func transpose(_ rows: [String]) -> [String] {
        guard let longestRow = rows.max(by: { $0.count < $1.count }) else {
            return []
        }
        
        return (0..<longestRow.count).map { index in
            transposeRow(in: rows, for: index)
        }
    }
    
    private static func transposeRow(in rows: [String], for index: Int) -> String {
        let characters = rows.map { character(in: $0, at: index) }

        guard let lastNonNil = characters.lastIndex(where: { $0 != nil }) else {
            return ""
        }

        return String(characters[...lastNonNil].map { $0 ?? " " })
    }

    private static func character(in row: String, at index: Int) -> Character? {
        let limit = row.index(before: row.endIndex)

        guard let i = row.index(row.startIndex, offsetBy: index, limitedBy: limit) else {
            return nil
        }

        return row[i]
    }
}