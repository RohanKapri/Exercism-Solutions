struct Bob {
    static func response(_ input: String) -> String {
        let remarkType = (
            silence: isSilent(input),
            shout: isShout(input),
            question: isQuestion(input)
        )

        switch remarkType {
        case (silence: true, shout: _, question: _):           return "Fine. Be that way!"
        case (silence: _, shout: true, question: true):        return "Calm down, I know what I'm doing!"
        case (silence: _, shout: true, question: _):           return "Whoa, chill out!"
        case (silence: _, shout: _, question: true):           return "Sure."
        default:                                               return "Whatever."
        }
    }

    private static func isSilent(_ input: String) -> Bool {
        input.allSatisfy(\.isWhitespace)
    }

    private static func isShout(_ input: String) -> Bool {
        input.contains(where: \.isLetter) && input.uppercased() == input
    }

    private static func isQuestion(_ input: String) -> Bool {
        input.last(where: { !$0.isWhitespace }) == "?"
    }
}