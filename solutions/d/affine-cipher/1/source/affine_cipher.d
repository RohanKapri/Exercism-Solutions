module affine_cipher;

import std.algorithm.iteration : filter, map;
import std.array : array, join;
import std.conv : to;
import std.exception : enforce;
import std.range : chunks;
import std.string : toLower;
import std.uni : isAlpha, isNumber;

pure int gcd(int a, int b)
{
    return b == 0 ? a : gcd(b, a % b);
}

pure string encode(immutable string phrase, uint a, uint b)
{
    immutable int m = 26;
    a %= m;
    b %= m;
    
    enforce(gcd(a, m) == 1, "Error: keyA and alphabet size must be coprime.");
    
    auto encoded = phrase.toLower
        .map!(ch => 
            isAlpha(ch) ? cast(char)('a' + (a * (ch - 'a') + b) % m) :
            isNumber(ch) ? ch : '\0')
        .filter!(ch => ch != '\0')
        .array;
    
    return encoded.chunks(5).map!(chunk => chunk.to!string).join(" ");
}

pure string decode(immutable string phrase, uint a, uint b)
{
    immutable int m = 26;
    a %= m;
    b %= m;
    
    enforce(gcd(a, m) == 1, "Error: keyA and alphabet size must be coprime.");
    
    int reversedA = 0;
    foreach (i; 0..m)
    {
        if ((a * i) % m == 1)
        {
            reversedA = i;
            break;
        }
    }
    
    return phrase
        .map!(ch => 
            isAlpha(ch) ? cast(char)('a' + (reversedA * (ch - 'a' - b + m) % m)) :
            isNumber(ch) ? ch : '\0')
        .filter!(ch => ch != '\0')
        .array
        .to!string;
}

unittest
{
    import std.algorithm.comparison : equal;
    import std.exception : assertThrown;

    immutable int allTestsEnabled = 0;

    // Encode-encode yes
    assert(equal("xbt", encode("yes", 5, 7)));

    static if (allTestsEnabled)
    {
        // Encode-encode no
        assert(equal("fu", encode("no", 15, 18)));

        // Encode-encode OMG
        assert(equal("lvz", encode("OMG", 21, 3)));

        // Encode-encode O M G
        assert(equal("hjp", encode("O M G", 25, 47)));

        // Encode-encode mindblowingly
        assert(equal("rzcwa gnxzc dgt", encode("mindblowingly", 11, 15)));

        // Encode-encode numbers
        assert(equal("jqgjc rw123 jqgjc rw", encode("Testing,1 2 3, testing.", 3, 4)));

        // Encode-encode deep thought
        assert(equal("iynia fdqfb ifje", encode("Truth is fiction.", 5, 17)));

        // Encode-encode all the letters
        assert(equal("swxtj npvyk lruol iejdc blaxk swxmh qzglf", encode("The quick brown fox jumps over the lazy dog.", 17, 33)));

        // Encode-encode with a not coprime to m
        assertThrown(encode("This is a test.", 6, 17));

        // Decode-decode exercism
        assert(equal("exercism", decode("tytgn fjr", 3, 7)));

        // Decode-decode a sentence
        assert(equal("anobstacleisoftenasteppingstone", decode("qdwju nqcro muwhn odqun oppmd aunwd o", 19, 16)));

        // Decode-decode numbers
        assert(equal("testing123testing", decode("odpoz ub123 odpoz ub", 25, 7)));

        // Decode-decode all the letters
        assert(equal("thequickbrownfoxjumpsoverthelazydog", decode("swxtj npvyk lruol iejdc blaxk swxmh qzglf", 17, 33)));

        // Decode-decode with no spaces in input
        assert(equal("thequickbrownfoxjumpsoverthelazydog", decode("swxtjnpvyklruoliejdcblaxkswxmhqzglf", 17, 33)));

        // Decode-decode with too many spaces
        assert(equal("jollygreengiant", decode("vszzm    cly   yd cg    qdp", 15, 16)));

        // Decode-decode with a not coprime to m
        assertThrown(decode("Test", 13, 5));
    }
}