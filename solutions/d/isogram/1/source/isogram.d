    module isogram;

pure bool isIsogram(immutable string phrase)
{
    int seen = 0;
    foreach (c; phrase)
    {
        uint letter = (c | 32);
        letter -= 'a';
        if (letter >= 26) {
            continue;
        }
        uint updated = seen | (1 << letter);
        if (updated == seen)
        {
            return false;
        }
        seen = updated;
    }
    return true;
}

unittest
{
    immutable int allTestsEnabled = 0;

    // Empty string
    assert(isIsogram(""));

    static if (allTestsEnabled)
    {
        // Isogram with only lower case characters
        assert(isIsogram("isogram"));

        // Word with one duplicated character
        assert(!isIsogram("eleven"));

        // Word with one duplicated character from the end of the alphabet
        assert(!isIsogram("zzyzx"));

        // Longest reported english isogram
        assert(isIsogram("subdermatoglyphic"));

        // Word with duplicated character in mixed case
        assert(!isIsogram("Alphabet"));

        // Word with duplicated character in mixed case, lowercase first
        assert(!isIsogram("alphAbet"));

        // Hypothetical isogrammic word with hyphen
        assert(isIsogram("thumbscrew-japingly"));

        // Hypothetical word with duplicated character following hyphen
        assert(!isIsogram("thumbscrew-jappingly"));

        // Isogram with duplicated hyphen
        assert(isIsogram("six-year-old"));

        // Made-up name that is an isogram
        assert(isIsogram("Emily Jung Schwartzkopf"));

        // Duplicated character in the middle
        assert(!isIsogram("accentor"));

        // Same first and last characters
        assert(!isIsogram("angola"));
    }
}