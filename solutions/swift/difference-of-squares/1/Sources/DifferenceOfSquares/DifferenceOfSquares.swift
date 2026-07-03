struct Squares {
    private let limit: Int
    
    init(_ limit: Int) {
        self.limit = limit
    }
    
    var squareOfSum: Int {
        let sum = (limit * (1 + limit)) / 2
        return sum * sum
    }

    var sumOfSquares: Int {
        (limit * (limit + 1) * (2 * limit + 1)) / 6
    }

    var differenceOfSquares: Int {
        squareOfSum - sumOfSquares
    }
}