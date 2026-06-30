module run_length_encoding;

import std.algorithm: group, map;
import std.array: join;
import std.conv: to;
import std.format: format;
import std.range: repeat;
import std.ascii: isDigit;

string encode(in string str) {
    return str.group
              .map!(g => format("%s%c", g[1] == 1 ? "" : to!string(g[1]), g[0]))
              .join;
}

string decode(in string str) {
    string result;
    string numStr;
    foreach (char c; str) {
        if (isDigit(c)) {
            numStr ~= c;
        } else {
            int count = numStr.length > 0 ? to!int(numStr) : 1;
            // Convert the range to a string before appending
            result ~= repeat(c.to!string, count).join("");
            numStr = "";
        }
    }
    return result;
}

unittest
{
    immutable int allTestsEnabled = 0;

    // Run-length encode a string

    // Empty string
    assert(encode("") == "");

    static if (allTestsEnabled)
    {
        // Single characters only are encoded without count
        assert(encode("XYZ") == "XYZ");

        // String with no single characters
        assert(encode("AABBBCCCC") == "2A3B4C");

        // Single characters mixed with repeated characters
        assert(encode("WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB") == "12WB12W3B24WB");

        // Multiple whitespace mixed in string
        assert(encode("  hsqq qww  ") == "2 hs2q q2w2 ");

        // Lowercase characters
        assert(encode("aabbbcccc") == "2a3b4c");

        // Sun-length decode a string

        // Empty string
        assert(decode("") == "");

        // String with no single characters
        assert(decode("XYZ") == "XYZ");

        // Single characters with repeated characters
        assert(decode("2A3B4C") == "AABBBCCCC");

        // Multiple whitespace mixed in string
        assert(decode("12WB12W3B24WB") == "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB");

        // Multiple whitespace mixed in string
        assert(decode("2 hs2q q2w2 ") == "  hsqq qww  ");

        // Lower case string
        assert(decode("2a3b4c") == "aabbbcccc");

        // Encode and then decode

        // Encode followed by decode gives original string
        assert("zzz ZZ  zZ".encode.decode == "zzz ZZ  zZ");
    }
}