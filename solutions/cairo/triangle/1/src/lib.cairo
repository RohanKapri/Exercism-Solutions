pub fn is_equilateral(sides: [u64; 3]) -> bool {
    let [a, b, c] = sides;
    is_valid_triangle(sides) && a == b && b == c
}

pub fn is_isosceles(sides: [u64; 3]) -> bool {
    let [a, b, c] = sides;
    is_valid_triangle(sides) && (a == b || b == c || a == c)
}

pub fn is_scalene(sides: [u64; 3]) -> bool {
    let [a, b, c] = sides;
    is_valid_triangle(sides) && a != b && b != c && a != c
}

fn is_valid_triangle(sides: [u64; 3]) -> bool {
    let [a, b, c] = sides;
    // All sides must be greater than 0
    a > 0 && b > 0 && c > 0 &&
    // Triangle inequality: sum of any two sides must be >= third side
    a + b >= c && b + c >= a && a + c >= b
}
  