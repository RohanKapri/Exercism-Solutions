import Foundation

enum PhoneNumberError: Error {
    case invalidPhoneNumber
}

struct PhoneNumber {
    private nonisolated(unsafe) static let invalidCharacters = #/[a-zA-Z@:!]+/#
    private static let formattingCharacters = CharacterSet(charactersIn: "+()-. ")
    private let rawInput: String

    init(_ number: String) {
        rawInput = number
    }

    func clean() throws -> String {
        guard hasOnlyValidCharacters(rawInput) else {
            throw PhoneNumberError.invalidPhoneNumber
        }

        var digits = removeFormattingCharacters(from: rawInput)

        guard isValidLength(digits) else {
            throw PhoneNumberError.invalidPhoneNumber
        }

        if digits.count == 11 {
            digits = String(digits.dropFirst())
        }

        guard hasValidAreaAndExchangeCodes(in: digits) else {
            throw PhoneNumberError.invalidPhoneNumber
        }

        return digits
    }

    private func hasOnlyValidCharacters(_ input: String) -> Bool {
        !input.contains(PhoneNumber.invalidCharacters)
    }

    private func removeFormattingCharacters(from number: String) -> String {
        number.components(separatedBy: PhoneNumber.formattingCharacters).joined()
    }

    private func isValidLength(_ input: String) -> Bool {
        input.count == 10 || (input.count == 11 && input.first == "1")
    }

    private func hasValidAreaAndExchangeCodes(in number: String) -> Bool {
        let digits = Array(number)
        return digits[0] >= "2" && digits[3] >= "2"
    }
}