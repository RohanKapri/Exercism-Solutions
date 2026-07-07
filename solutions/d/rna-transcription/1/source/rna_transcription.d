module rna_transcription;

pure string toRna(string dna)
{
    string result;
    foreach (d; dna)
    {
        char r;
        switch(d)
        {
            case 'G':
                r = 'C';
                break;
            case 'C':
                r = 'G';
                break;
            case 'T':
                r = 'A';
                break;
            case 'A':
                r = 'U';
                break;
            default:
                assert(0);
        }
        result ~= r;
    }
    return result;
}

unittest
{
    import std.exception : assertThrown;

    immutable int allTestsEnabled = 0;

    // Empty RNA sequence
    assert(toRna("") == "");

    static if (allTestsEnabled)
    {
        // RNA complement of cytosine is guanine
        assert(toRna("C") == "G");

        // RNA complement of guanine is cytosine
        assert(toRna("G") == "C");

        // RNA complement of thymine is adenine
        assert(toRna("T") == "A");

        // RNA complement of adenine is uracil
        assert(toRna("A") == "U");

        // RNA complement
        assert(toRna("ACGTGGTCTTAA") == "UGCACCAGAAUU");
    }

}