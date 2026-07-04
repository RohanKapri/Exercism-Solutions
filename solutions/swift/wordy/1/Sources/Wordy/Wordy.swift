enum WordyError: Error {
    case syntaxError
}

func wordyAnswer(_ question: String) throws -> Int {
    let equation = try extractEquation(from: question)

    return try solve(equation)
}

private func extractEquation(from question: String) throws -> [String] {
    let equation = question.replacing(#/What is |by |\?/#, with: "").split(separator: " ").map(String.init)

    guard hasAlternatingStructure(equation) else {
        throw WordyError.syntaxError
    }

    return equation
}

private func hasAlternatingStructure(_ tokens: [String]) -> Bool {
    !tokens.count.isMultiple(of: 2)
}

private func solve(_ equation: [String]) throws -> Int {
    guard let firstOperand = Int(equation[0]) else {
        throw WordyError.syntaxError
    }

    let end = equation.count

    return try stride(from: 1, to: end, by: 2).reduce(firstOperand) { operand1, index in
        guard let operand2 = Int(equation[index + 1]) else {
            throw WordyError.syntaxError
        }

        let operation = equation[index]

        switch operation {
        case "plus":
            return operand1 + operand2
        case "minus":
            return operand1 - operand2
        case "multiplied":
            return operand1 * operand2
        case "divided":
            return operand1 / operand2
        default:
            throw WordyError.syntaxError
        }
    }
}