private enum Signal: Int, CaseIterable {
    static let reverseBit = 0b10000

    case wink = 0b0001
    case doubleBlink = 0b0010
    case closeYourEyes = 0b0100
    case jump = 0b1000

    var action: String {
        switch self {
        case .wink:         return "wink"
        case .doubleBlink:  return "double blink"
        case .closeYourEyes: return "close your eyes"
        case .jump:         return "jump"
        }
    }
}

func commands(number: Int) -> [String] {
    let actions = signals(in: number).map { $0.action }
    return number & Signal.reverseBit != 0 ? actions.reversed() : actions
}

private func signals(in number: Int) -> [Signal] {
    Signal.allCases.filter { number & $0.rawValue == $0.rawValue }
}