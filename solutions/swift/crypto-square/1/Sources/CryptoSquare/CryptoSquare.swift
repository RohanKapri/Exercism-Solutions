import Foundation

func cryptoSquare(text: String) -> String {
    let normalized = text.filter {
        $0.isLetter || $0.isNumber
    }.map {
        $0.lowercased()
    }

    let c = Int(ceil(Double(normalized.count).squareRoot()))

    var squared = normalized.enumerated().reduce(into: Array(repeating: String(), count: c)) {
        ret, idxchar in
        let (i, char) = idxchar
        ret[i % c] += char
    }

    guard let first = squared.first else { return "" }
    let len = first.count
    
    return squared.map {
        guard $0.count < len else { return $0 }
        return $0 + " "
    }.joined(separator: " ")
}