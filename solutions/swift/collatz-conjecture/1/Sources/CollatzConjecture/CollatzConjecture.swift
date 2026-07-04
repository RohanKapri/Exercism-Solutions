struct CollatzConjecture {
    enum Error: Swift.Error {
        case invalidInput
    }

    static func steps(_ n: Int) throws -> Int {
        guard n > 0 else { throw Error.invalidInput }

        var count = 0
        var number = n

        while number > 1 {
            number = number.isMultiple(of: 2) ? number / 2 : 3 * number + 1
            count += 1
        }

        return count
    }
}