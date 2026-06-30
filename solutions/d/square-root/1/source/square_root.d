module square_root;

pure int squareRoot(immutable int radicand)
{
    int previous;
    int current = 1;
    do
    {
        previous = current;
        current = (previous * (previous + 1) + radicand) / (2 * previous);
    }
    while (previous != current);
    return current;
}

unittest
{
    immutable int allTestsEnabled = 0;

    // root of 1
    assert(squareRoot(1) == 1);

    static if (allTestsEnabled)
    {
        // root of 4
        assert(squareRoot(4) == 2);

        // root of 25
        assert(squareRoot(25) == 5);

        // root of 81
        assert(squareRoot(81) == 9);

        // root of 196
        assert(squareRoot(196) == 14);

        // root of 65025
        assert(squareRoot(65025) == 255);
    }
}