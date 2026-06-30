module triangle;

import std.exception : enforce;

enum TriangleType
{
    equilateral,
    isosceles,
    scalene
}

TriangleType kind(double a, double b, double c)
{
    enforce(a > 0 && b > 0 && c > 0, "Invalid triangle");

    enforce(a + b >= c &&
            a + c >= b &&
            b + c >= a,
            "Triangle inequality violated");

    if (a == b && b == c)
        return TriangleType.equilateral;

    if (a == b || b == c || a == c)
        return TriangleType.isosceles;

    return TriangleType.scalene;
}

unittest
{
    import std.exception : assertThrown;

    immutable int allTestsEnabled = 0;

    // equilateral triangle - all sides are equal
    {
        assert(TriangleType.equilateral == kind(2, 2, 2));
    }

    static if (allTestsEnabled)
    {
        // ... all your existing tests ...
    }
}