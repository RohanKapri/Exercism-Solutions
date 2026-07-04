enum PalindromeError: Error {
    case invalidRange
}

typealias Palindrome = (value: Int?, factors: Set<[Int]>)

struct PalindromeProducts {

    static func smallest(from min: Int, to max: Int) throws -> Palindrome {
        try find(from: min, to: max, sentinel: .max, reversed: false, isBetter: <)
    }

    static func largest(from min: Int, to max: Int) throws -> Palindrome {
        try find(from: min, to: max, sentinel: .min, reversed: true, isBetter: >)
    }

    private static func find(
        from min: Int,
        to max: Int,
        sentinel: Int,
        reversed: Bool,
        isBetter: (Int, Int) -> Bool
    ) throws -> Palindrome {
        guard min <= max else {
            throw PalindromeError.invalidRange
        }

        let firstFactors = reversed ? Array((min...max).reversed()) : Array(min...max)
        var best = sentinel
        var factors: Set<[Int]> = []

        for x in firstFactors {
            var hadBetter = false
            let secondFactors = reversed ? Array((x...max).reversed()) : Array(x...max)

            for y in secondFactors {
                let product = x * y

                if product == best, isPalindrome(product) {
                    factors.insert([x, y])
                }

                if isBetter(product, best) {
                    hadBetter = true

                    if !isPalindrome(product) {
                        continue
                    }

                    best = product
                    factors = [[x, y]]
                }
            }

            if !hadBetter {
                break
            }
        }

        return (value: best == sentinel ? nil : best, factors)
    }

    private static func isPalindrome(_ value: Int) -> Bool {
        let number = String(value)

        return String(number.reversed()) == number
    }
}