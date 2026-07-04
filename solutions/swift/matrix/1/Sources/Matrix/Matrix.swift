struct Matrix {
    let rows: [[Int]]
    let columns: [[Int]]

    init(_ input: String) {
        let rows = input.split(separator: "\n").map { row in
            row.split(separator: " ").compactMap { Int($0) }
        }

        self.rows = rows
        self.columns = (0..<(rows.first?.count ?? 0)).map { i in rows.map { $0[i] } }
    }
}