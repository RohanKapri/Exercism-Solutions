enum BaseError: Error {
    case negativeDigit
    case invalidPositiveDigit
    case invalidInputBase
    case invalidOutputBase
}

struct Base {
    static func outputDigits(inputBase: Int, inputDigits: [Int], outputBase: Int) throws -> [Int] {

        guard inputBase > 1 else {
            throw BaseError.invalidInputBase
        }

        guard outputBase > 1 else {
            throw BaseError.invalidOutputBase
        }

        guard inputDigits.allSatisfy({ $0 >= 0 }) else {
            throw BaseError.negativeDigit
        }

        guard inputDigits.allSatisfy({ $0 < inputBase }) else {
            throw BaseError.invalidPositiveDigit
        }

        let decimal = convertToDecimal(digits: inputDigits, from: inputBase)
        return convertFromDecimal(number: decimal, to: outputBase)
    }

    private static func convertToDecimal(digits: [Int], from base: Int) -> Int {
        digits.reduce(0) { acc, digit in acc * base + digit }
    }

    private static func convertFromDecimal(number: Int, to base: Int) -> [Int] {
        var output = [Int]()
        var decimal = number
        
        while decimal / base > 0 {
            output.append(decimal % base)
            decimal /= base
        }
        
        output.append(decimal)

        return output.reversed()
    }
}