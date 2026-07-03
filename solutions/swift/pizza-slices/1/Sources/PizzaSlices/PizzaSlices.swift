func sliceSize(diameter: Double?, slices: Int?) -> Double? {
    guard let d = diameter, let s = slices else {
        return nil
    }
    
    guard d >= 0, s > 0 else {
        return nil
    }
    
    let radius = d / 2
    let area = Double.pi * radius * radius
    
    return area / Double(s)
}

func biggestSlice(
  diameterA: String, slicesA: String,
  diameterB: String, slicesB: String
) -> String {
    let areaA = sliceSize(diameter: Double(diameterA), slices: Int(slicesA))
    let areaB = sliceSize(diameter: Double(diameterB), slices: Int(slicesB))
    
    switch (areaA, areaB) {
    case (_?, nil): return "Slice A is bigger"
    case (nil, _?): return "Slice B is bigger"
    case let (a?, b?):
        if a > b { return "Slice A is bigger" }
        if b > a { return "Slice B is bigger" }
        return "Neither slice is bigger"
    default: return "Neither slice is bigger"
    }
}