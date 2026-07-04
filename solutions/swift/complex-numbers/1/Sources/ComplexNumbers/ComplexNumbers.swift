import Foundation
import RealModule

struct ComplexNumbers: Equatable {
    let real: Double
    let imaginary: Double

    init(realComponent: Double, imaginaryComponent: Double?) {
        self.real = realComponent
        self.imaginary = imaginaryComponent ?? 0
    }

    static func == (lhs: ComplexNumbers, rhs: ComplexNumbers) -> Bool {
        lhs.real.isApproximatelyEqual(to: rhs.real, absoluteTolerance: 0.00001)
            && lhs.imaginary.isApproximatelyEqual(to: rhs.imaginary, absoluteTolerance: 0.00001)
    }

    func add(complexNumber: ComplexNumbers) -> ComplexNumbers {
        let real = self.real + complexNumber.real
        let imaginary = self.imaginary + complexNumber.imaginary

        return ComplexNumbers(realComponent: real, imaginaryComponent: imaginary)
    }

    func sub(complexNumber: ComplexNumbers) -> ComplexNumbers {
        let real = self.real - complexNumber.real
        let imaginary = self.imaginary - complexNumber.imaginary

        return ComplexNumbers(realComponent: real, imaginaryComponent: imaginary)
    }

    func mul(complexNumber: ComplexNumbers) -> ComplexNumbers {
        let real = (self.real * complexNumber.real) - (self.imaginary * complexNumber.imaginary)
        let imaginary = (self.real * complexNumber.imaginary) + (self.imaginary * complexNumber.real)

        return ComplexNumbers(realComponent: real, imaginaryComponent: imaginary)
    }

    func div(complexNumber: ComplexNumbers) -> ComplexNumbers {
        mul(complexNumber: complexNumber.inverse())
    }

    func absolute() -> Double {
        return sqrt(real * real + imaginary * imaginary)
    }

    func conjugate() -> ComplexNumbers {
        return ComplexNumbers(realComponent: real, imaginaryComponent: -imaginary)
    }

    func exponent() -> ComplexNumbers {
        let real = ComplexNumbers(realComponent: exp(self.real), imaginaryComponent: 0)
        let imaginary = ComplexNumbers(realComponent: cos(self.imaginary), imaginaryComponent: sin(self.imaginary))

        return real.mul(complexNumber: imaginary)
    }

    private func inverse() -> ComplexNumbers {
        let denominator = real * real + imaginary * imaginary
        let real = self.real / denominator
        let imaginary = -self.imaginary / denominator

        return ComplexNumbers(realComponent: real, imaginaryComponent: imaginary)
    }
}
