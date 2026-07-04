private let ones = [
    "", "one", "two", "three", "four", "five",
    "six", "seven", "eight", "nine", "ten", "eleven",
    "twelve", "thirteen", "fourteen", "fifteen",
    "sixteen", "seventeen", "eighteen", "nineteen"
]
private let tens = ["", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]

enum SayError: Error {
    case outOfRange
}

func say(number: Int) throws -> String {
    guard (0...999_999_999_999).contains(number) else {
        throw SayError.outOfRange
    }

    return number == 0 ? "zero" : convert(number)
}

private func convert(_ number: Int) -> String {
    switch number {
    case 1..<20:
        return ones[number]
    case 20..<100:
        return number.isMultiple(of: 10)
            ? tens[number / 10]
            : "\(tens[number / 10])-\(ones[number % 10])"
    case 100..<1_000:
        return words(for: number, scale: "hundred", divisor: 100)
    case 1_000..<1_000_000:
        return words(for: number, scale: "thousand", divisor: 1_000)
    case 1_000_000..<1_000_000_000:
        return words(for: number, scale: "million", divisor: 1_000_000)
    default:
        return words(for: number, scale: "billion", divisor: 1_000_000_000)
    }
}

private func words(for number: Int, scale: String, divisor: Int) -> String {
    let head = "\(convert(number / divisor)) \(scale)"
    let remainder = number % divisor

    return remainder == 0 ? head : "\(head) \(convert(remainder))"
}