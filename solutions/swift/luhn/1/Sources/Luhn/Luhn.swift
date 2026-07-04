func isValidLuhn(_ input: String) -> Bool {
    let digits = input.filter { $0 != " " }

    guard hasValidFormat(digits) else { return false }

    return checksum(of: digits) % 10 == 0
}

private func hasValidFormat(_ digits: String) -> Bool {
    digits.count > 1 && digits.allSatisfy { $0.isNumber }
}

private func checksum(of digits: String) -> Int {
    digits.reversed().enumerated().reduce(0) { sum, pair in
        let (index, char) = pair
        var digit = char.wholeNumberValue!

        if index % 2 == 1 {
            digit *= 2
            if digit > 9 { digit -= 9 }
        }

        return sum + digit
    }
}