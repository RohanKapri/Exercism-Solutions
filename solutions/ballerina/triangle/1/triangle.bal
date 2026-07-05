enum TriangleType {
    EQUILATERAL,
    ISOSCELES,
    SCALENE
}

# Determines the type of triangle based on the sides
# 
# + sides - The sides of the triangle
# + t - The type of triangle
# + return - Whether the sides form the triangle type
function kind(float[]|int[] sides, TriangleType t) returns boolean {
    if sides.length() != 3 {
        return false;
    }

    float a;
    float b;
    float c;
    if sides is float[] {
        a = sides[0];
        b = sides[1];
        c = sides[2];
    } else {
        int[] intSides = <int[]>sides;
        a = <float>intSides[0];
        b = <float>intSides[1];
        c = <float>intSides[2];
    }

    boolean isValidTriangle = isValid(a, b, c);
    if !isValidTriangle {
        return false;
    }

    boolean isEquilateral = a == b && b == c;
    boolean isIsosceles = isEquilateral || a == b || b == c || a == c;
    boolean isScalene = a != b && b != c && a != c;

    if t == EQUILATERAL {
        return isEquilateral;
    } else if t == ISOSCELES {
        return isIsosceles;
    }
    return isScalene;
}

function isValid(float a, float b, float c) returns boolean {
    if a <= 0.0 || b <= 0.0 || c <= 0.0 {
        return false;
    }

    return a + b >= c && b + c >= a && a + c >= b;
}