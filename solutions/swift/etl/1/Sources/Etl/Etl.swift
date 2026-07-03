struct ETL {
    static func transform(_ original: [String: [String]]) -> [String: Int] {
        let pairs = original.flatMap { score, letters -> [(String, Int)] in
            guard let value = Int(score) else { return [] }

            return letters.map { ($0.lowercased(), value) }
        }

        return Dictionary(uniqueKeysWithValues: pairs)
    }
}