module etl;

import std.ascii : toLower;

pure int[dchar] transform(immutable string[int] score_map)
{
    int[dchar] result;

    foreach (score, letters; score_map)
    {
        foreach (ch; letters)
        {
            result[toLower(ch)] = score;
        }
    }

    return result;
}

unittest
{

    // test associative array equality
    bool aaEqual(const int[dchar] lhs, const int[dchar] rhs)
    {
        import std.array : array;
        import std.algorithm.sorting : sort;
        import std.algorithm.comparison : equal;

        auto lhsPairs = lhs.byKeyValue.array;
        auto rhsPairs = rhs.byKeyValue.array;
        lhsPairs.sort!(q{a.key < b.key});
        rhsPairs.sort!(q{a.key < b.key});

        return equal!("a.key == b.key && a.value == b.value")(lhsPairs, rhsPairs);
    }

    immutable int allTestsEnabled = 0;

    // Single letter
    {
        immutable string[int] old = [1 : "A"];

        const auto actual = transform(old);
        const int[dchar] expected = ['a' : 1];

        assert(aaEqual(expected, actual));
    }

    static if (allTestsEnabled)
    {
        // ... remaining tests unchanged ...
    }
}