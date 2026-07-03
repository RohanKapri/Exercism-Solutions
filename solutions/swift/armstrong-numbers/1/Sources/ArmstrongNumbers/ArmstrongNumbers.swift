func isArmstrongNumber(_ number: Int) -> Bool {
    let digits = String(number).compactMap(\.wholeNumberValue)
    let count = digits.count

    return digits.reduce(0) { sum, digit in sum + digit.power(to: count) } == number
}

private extension Int {
    func power(to exponent: Int) -> Int {
        repeatElement(self, count: exponent).reduce(1, *)
    }
}