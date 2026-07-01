module [is_equilateral, is_isosceles, is_scalene]

epsilon : F64
epsilon = 1.0e-9

approxEqual : F64, F64 -> Bool
approxEqual = |a, b|
    Num.abs(a - b) < epsilon

isValidTriangle : (F64, F64, F64) -> Bool
isValidTriangle = |(a, b, c)|
    a > 0 && b > 0 && c > 0 && a + b > c && b + c > a && a + c > b

is_equilateral : (F64, F64, F64) -> Bool
is_equilateral = |(a, b, c)|
    isValidTriangle((a, b, c)) && approxEqual(a, b) && approxEqual(b, c)

is_isosceles : (F64, F64, F64) -> Bool
is_isosceles = |(a, b, c)|
    isValidTriangle((a, b, c)) && (approxEqual(a, b) || approxEqual(b, c) || approxEqual(a, c))

is_scalene : (F64, F64, F64) -> Bool
is_scalene = |(a, b, c)|
    isValidTriangle((a, b, c)) && Bool.not(approxEqual(a, b)) && Bool.not(approxEqual(b, c)) && Bool.not(approxEqual(a, c))
    