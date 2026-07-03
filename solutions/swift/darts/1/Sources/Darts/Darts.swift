func dartScore(x: Double, y: Double) -> Int {
    let distance = (x * x + y * y).squareRoot()

    switch distance {
    case ...1:  return 10
    case ...5:  return 5
    case ...10: return 1
    default:    return 0
    }
}