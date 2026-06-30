module atbash_cipher;

import std.ascii : isAlphaNum, isDigit, toLower;

pure dchar atbashTransform(dchar c)
{
    if (isAlphaNum(c) && !isDigit(c)) {
        return 'a' + 'z' - toLower(c);
    }
    
    return c;
}

pure string encode(immutable string phrase)
{
    size_t nextSpace = 5;
    string result;
    
    foreach (dchar c; phrase) {
        if (!isAlphaNum(c)) {
            continue;
        }
        
        if (result.length == nextSpace) {
            result ~= ' ';
            nextSpace += 6;
        }
        
        result ~= atbashTransform(c);
    }
    
    return result;
}

pure string decode(immutable string phrase)
{
    string result;
    
    foreach (dchar c; phrase) {
        if (c == ' ') {
            continue;
        }
        
        result ~= atbashTransform(c);
    }
    
    return result;
}

unittest
{
    immutable int allTestsEnabled = 0;

    // Encode yes
    assert(encode("yes") == "bvh");

    static if (allTestsEnabled)
    {
        // Encode no
        assert(encode("no") == "ml");

        // Encode OMG
        assert(encode("OMG") == "lnt");

        // Encode spaces
        assert(encode("O M G") == "lnt");

        // Encode mindblowingly
        assert(encode("mindblowingly") == "nrmwy oldrm tob");

        // Encode numbers
        assert(encode("Testing,1 2 3, testing.") == "gvhgr mt123 gvhgr mt");

        // Encode deep thought
        assert(encode("Truth is fiction.") == "gifgs rhurx grlm");

        // Encode all the letters
        assert(encode("The quick brown fox jumps over the lazy dog.") == "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt");

        // Decode exercism
        assert(decode("vcvix rhn") == "exercism");

        // Decode a sentence
        assert(decode("zmlyh gzxov rhlug vmzhg vkkrm thglm v") == "anobstacleisoftenasteppingstone");

        // Decode numbers
        assert(decode("gvhgr mt123 gvhgr mt") == "testing123testing");

        // Decode all the letters
        assert(decode("gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt") == "thequickbrownfoxjumpsoverthelazydog");

        // Decode with too many spaces
        assert(decode("vc vix    r hn") == "exercism");

        // Decode with no spaces
        assert(decode("zmlyhgzxovrhlugvmzhgvkkrmthglmv") == "anobstacleisoftenasteppingstone");
    }
}