module simple_cipher;

import std.random;

private immutable char[26][26] encodeTable;
private immutable char[26][26] decodeTable;

shared static this() {
    foreach (ubyte s; 0 .. 26)
        foreach (ubyte c; 0 .. 26) {
            encodeTable[s][c] = cast(char)('a' + (c + s) % 26);
            decodeTable[s][c] = cast(char)('a' + (c + 26 - s) % 26);
        }
}

class VigenereCipher {
    private string key;
    private ubyte[] encodeShifts;
    private ubyte[] expandedEncodeShifts;

    this(string key = "") {
        this.key = key;
        if (this.key.length == 0)
            generateRandomKey();
        buildShiftTables();
    }

    string getKey() const {
        return key;
    }

    private void generateRandomKey() {
        key = "";
        key.reserve(100);
        foreach (_; 0 .. 100)
            key ~= cast(char) uniform('a', 'z' + 1);
    }

    private void buildShiftTables() {
        encodeShifts = new ubyte[key.length];
        foreach (size_t i; 0 .. key.length)
            encodeShifts[i] = cast(ubyte)(key[i] - 'a');
    }

    string encode(string plaintext) {
        return transform(plaintext, encodeShifts, encodeTable);
    }

    string decode(string ciphertext) {
        return transform(ciphertext, encodeShifts, decodeTable);
    }

    private void expandShiftsForLetters(scope const(ubyte)[] shifts, in string text) {
        size_t letterCount;
        foreach (char c; text)
            if (c >= 'a' && c <= 'z')
                letterCount++;

        if (expandedEncodeShifts.length < letterCount)
            expandedEncodeShifts = new ubyte[letterCount];

        size_t pos;
        while (pos < letterCount) {
            immutable size_t chunk = (letterCount - pos < shifts.length)
                ? letterCount - pos
                : shifts.length;
            expandedEncodeShifts[pos .. pos + chunk] = shifts[0 .. chunk];
            pos += chunk;
        }
    }

    private string transform(
        in string text,
        scope const(ubyte)[] shifts,
        scope const(char[26][26]) table,
    ) {
        if (text.length == 0)
            return text;

        char[] result = new char[text.length];
        result[] = text;

        size_t letterCount;
        foreach (char c; text)
            if (c >= 'a' && c <= 'z')
                letterCount++;

        immutable bool useExpanded = letterCount >= shifts.length * 4;
        if (useExpanded)
            expandShiftsForLetters(shifts, text);

        size_t keyIdx;
        size_t letterIdx;
        immutable size_t keyLen = shifts.length;

        foreach (size_t i; 0 .. result.length) {
            immutable char c = result[i];
            if (c >= 'a' && c <= 'z') {
                immutable ubyte shift = useExpanded
                    ? expandedEncodeShifts[letterIdx++]
                    : shifts[keyIdx];
                result[i] = table[shift][c - 'a'];
                if (!useExpanded && ++keyIdx == keyLen)
                    keyIdx = 0;
            }
        }

        return cast(string) result;
    }
}

unittest {
    auto cipher = new VigenereCipher("abcd");
    assert(cipher.encode("hello") == "hfnoo");
}

unittest {
    auto cipher = new VigenereCipher("abcd");
    string original = "hello";
    auto encoded = cipher.encode(original);
    auto decoded = cipher.decode(encoded);

    assert(decoded == original);
}

unittest {
    auto cipher = new VigenereCipher("d");
    assert(cipher.encode("abc") == "def");
    assert(cipher.decode("def") == "abc");
}

unittest {
    auto cipher = new VigenereCipher("a");
    assert(cipher.encode("hello") == "hello");
    assert(cipher.decode("hello") == "hello");
}

unittest {
    auto cipher = new VigenereCipher("ab");
    assert(cipher.encode("aaaa") == "abab");
}

unittest {
    auto cipher = new VigenereCipher("abc");
    assert(cipher.encode("hello world!") == "hfnlp yosnd!");
}

unittest {
    auto cipher = new VigenereCipher();
    assert(cipher.getKey().length >= 100);
    foreach (char c; cipher.getKey())
        assert(c >= 'a' && c <= 'z');
}