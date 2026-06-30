module crypto;

import std.algorithm : map;
import std.array : array, join;
import std.conv : to;
import std.math : ceil, sqrt;
import std.range : chunks, transposed;
import std.regex : ctRegex, replaceAll;
import std.string : toLower;

class Cipher {
    private const string text;
    private const bool normalized;
    
    this(in string text) pure @safe {
        this(text, false);
    }
    
    private this(in string text, bool normalized) pure @safe {
        this.text = text;
        this.normalized = normalized;
    }
    
    string normalizePlainText() const @safe {
        auto charsToReplace = ctRegex!`\W`;
        return replaceAll(text, charsToReplace, "").toLower;
    }
    
    size_t size() const @safe {
        return sqrt(normalizePlainText().length.to!float).ceil.to!ulong;
    }
    
    string[] plainTextSegments() const @safe {
        return normalizePlainText()
            .chunks(size())
            .map!(chunk => chunk.to!string) // Explicit use of map from std.algorithm.iteration
            .array;
    }
    
    string cipherText() const @safe {
        // Utilizing join from std.algorithm.iteration for combining elements, enhanced readability
        return plainTextSegments().transposed.map!(a => a.array).join(normalized ? " " : "").to!string;
    }
    
    Cipher normalize() const @safe {
        return new Cipher(this.normalizePlainText(), true);
    }
}

unittest
{
    immutable int allTestsEnabled = 0;

    // normalize_strange_characters
    {
        auto theCipher = new Cipher("s#$%^&plunk");
        assert("splunk" == theCipher.normalizePlainText());
    }

    static if (allTestsEnabled)
    {
        // normalize_numbers
        {
            auto theCipher = new Cipher("1, 2, 3 GO!");
            assert("123go" == theCipher.normalizePlainText());
        }

        // size_of_small_square
        {
            auto theCipher = new Cipher("1234");
            assert(2U == theCipher.size());
        }

        // size_of_slightly_larger_square
        {
            auto theCipher = new Cipher("123456789");
            assert(3U == theCipher.size());
        }

        // size_of_non_perfect_square
        {
            auto theCipher = new Cipher("123456789abc");
            assert(4U == theCipher.size());
        }

        // size_of_non_perfect_square_less
        {
            auto theCipher = new Cipher("zomgzombies");
            assert(4U == theCipher.size());
        }

        // plain_text_segments_from_phrase
        {
            const string[] expected = [
                "neverv", "exthin", "eheart", "withid", "lewoes"
            ];
            auto theCipher = new Cipher("Never vex thine heart with idle woes");
            const auto actual = theCipher.plainTextSegments();

            assert(expected == actual);
        }

        // plain_text_segments_from_complex_phrase
        {
            const string[] expected = ["zomg", "zomb", "ies"];
            auto theCipher = new Cipher("ZOMG! ZOMBIES!!!");
            const auto actual = theCipher.plainTextSegments();

            assert(expected == actual);
        }

        // Cipher_text_short_phrase
        {
            auto theCipher = new Cipher("Time is an illusion. Lunchtime doubly so.");
            assert("tasneyinicdsmiohooelntuillibsuuml" == theCipher.cipherText());
        }

        // Cipher_text_long_phrase
        {
            auto theCipher = new Cipher("We all know interspecies romance is weird.");
            assert("wneiaweoreneawssciliprerlneoidktcms" == theCipher.cipherText());
        }

        // normalized_Cipher_text1
        {
            auto theCipher = new Cipher("Madness, and then illumination.");
            assert("msemo aanin dnin ndla etlt shui" == theCipher.normalize.cipherText());
        }

        // normalized_Cipher_text2
        {
            auto theCipher = new Cipher("Vampires are people too!");
            assert("vrel aepe mset paoo irpo" == theCipher.normalize.cipherText());
        }
    }

}