module hamming;

pure int distance(immutable string strand1, immutable string strand2) {
    ulong len = strand1.length;
    if (len != strand2.length) {
        throw new Exception("Unequal strand lengths");
    }

    int result = 0;
    for (ulong i = 0; i < len; ++i) {
        if (strand1[i] != strand2[i]) {
            ++result;
        }
    }
    return result;
}

unittest
{
    import std.exception : assertThrown;

    immutable int allTestsEnabled = 0;

    // Empty strands
    assert(distance("", "") == 0);

    static if (allTestsEnabled)
    {
        // Single letter identical strands
        assert(distance("A", "A") == 0);

        // Single letter different strands
        assert(distance("G", "T") == 1);

        // Long identical strands
        assert(distance("GGACTGAAATCTG", "GGACTGAAATCTG") == 0);

        // Long different strands
        assert(distance("GGACGGATTCTG", "AGGACGGATTCT") == 9);

        // Disallow first strand longer 
        assertThrown(distance("AATG", "AAA"));

        // Disallow second strand longer
        assertThrown(distance("AAA", "AGTG"));

        // Disallow left empty strand
        assertThrown(distance("", "G"));

        // Disallow right empty strand
        assertThrown(distance("G", ""));
    }

}