enum GrainsError: Error {
    case inputTooHigh
    case inputTooLow
}

struct Grains {
    private static let minSquare = 1
    private static let maxSquare = 64

    static var total: UInt64 {
        (minSquare...maxSquare).reduce(0) { acc, square in acc + grains(in: square) }
    }
    
    static func square(_ square: Int) throws -> UInt64 {
        guard square >= minSquare else {
            throw GrainsError.inputTooLow
        }
        
        guard square <= maxSquare else {
            throw GrainsError.inputTooHigh
        }
        
        return grains(in: square)
    }
    
    private static func grains(in square: Int) -> UInt64 {
        UInt64(1) << (square - 1)
    }
}