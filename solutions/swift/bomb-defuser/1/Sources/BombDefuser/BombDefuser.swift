typealias Wires = (String, String, String)
typealias Shuffler = ([UInt8], Wires) -> Wires
typealias ChangeClosure = @Sendable (Wires) -> Wires

let flip: ChangeClosure = { ($0.1, $0.0, $0.2) }
let rotate: ChangeClosure = { ($0.1, $0.2, $0.0) }

func makeShuffle(flipper: @escaping ChangeClosure, rotator: @escaping ChangeClosure) -> Shuffler {
    { bits, wires in
        bits.reversed().reduce(wires) { wires, bit in
            bit == 0 ? flipper(wires) : rotator(wires)
        }
    }
}