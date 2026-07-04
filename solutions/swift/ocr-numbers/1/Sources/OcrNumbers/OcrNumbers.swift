enum OcrNumberError: Error {
    case invalidInput
}

struct OcrNumber {
    private static let ocrDecimalValues = [
        [" _ ", "| |", "|_|"]: "0",
        ["   ", "  |", "  |"]: "1",
        [" _ ", " _|", "|_ "]: "2",
        [" _ ", " _|", " _|"]: "3",
        ["   ", "|_|", "  |"]: "4",
        [" _ ", "|_ ", " _|"]: "5",
        [" _ ", "|_ ", "|_|"]: "6",
        [" _ ", "  |", "  |"]: "7",
        [" _ ", "|_|", "|_|"]: "8",
        [" _ ", "|_|", " _|"]: "9",
    ]

    static func convert(rows: [String]) throws -> String {
        guard hasValidRowCount(rows) else {
            throw OcrNumberError.invalidInput
        }

        guard hasValidColumnCount(rows) else {
            throw OcrNumberError.invalidInput
        }

        let ocrNumbers = chunk(rows, by: 4).map(transpose)

        return convert(ocrNumbers: ocrNumbers)
    }

    private static func hasValidRowCount(_ rows: [String]) -> Bool {
        rows.count.isMultiple(of: 4)
    }

    private static func hasValidColumnCount(_ rows: [String]) -> Bool {
        rows.allSatisfy { $0.count.isMultiple(of: 3) }
    }

    private static func chunk(_ rows: [String], by size: Int) -> [[String]] {
        stride(from: 0, to: rows.count, by: size).map { i -> [String] in
            Array(rows[i..<i + size])
        }
    }

    private static func transpose(rows: [String]) -> [[String]] {
        stride(from: 0, to: rows[0].count, by: 3).map { column in
            rows.dropLast().map { row in
                let startIndex = row.index(row.startIndex, offsetBy: column)
                let endIndex = row.index(startIndex, offsetBy: 3)

                return String(row[startIndex..<endIndex])
            }
        }
    }

    private static func convert(ocrNumbers: [[[String]]]) -> String {
        ocrNumbers.map { ocrGroup in
            ocrGroup.map { ocrDecimalValues[$0, default: "?"] }.joined()
        }.joined(separator: ",")
    }
}