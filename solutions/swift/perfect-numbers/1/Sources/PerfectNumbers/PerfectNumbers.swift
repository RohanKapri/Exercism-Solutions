enum Classification {
    case perfect
    case deficient
    case abundant
}

enum ClassificationError: Error {
    case invalidInput
}

func classify(number: Int) throws -> Classification {
    guard number >= 1 else {
        throw ClassificationError.invalidInput
    }
    
    let aliquotSum = factors(of: number).reduce(0, +)
    
    switch aliquotSum {
    case ..<number: return .deficient
    case number:    return .perfect
    default:        return .abundant
    }
}

private func factors(of number: Int) -> [Int] {
    if number <= 2 {
        return []
    }
        
    let limit = Int(Double(number).squareRoot())
    var divisors: [Int] = [1]

    for factor in stride(from: 2, through: limit, by: 1) {
        if number.isMultiple(of: factor) {
            divisors.append(factor)

            if factor != number / factor {
                divisors.append(number / factor)
            }
        }
    }

    return divisors
}