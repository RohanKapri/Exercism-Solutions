struct Triangle {
    private let sides: [Double]
    private let isValid: Bool
    
    init(_ sides: [Double]) {
        self.sides = sides
        self.isValid = sides.allSatisfy { $0 > 0 } && 2 * sides.max()! <= sides.reduce(0, +)
    }
    
    var isEquilateral: Bool {
        isValid && sides.allSatisfy { $0 == sides[0] }
    }
    
    var isIsosceles: Bool {
        isValid && (sides[0] == sides[1] || sides[1] == sides[2] || sides[0] == sides[2])
    }
    
    var isScalene: Bool {
        isValid && !isIsosceles
    }
}