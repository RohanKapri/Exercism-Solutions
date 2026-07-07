module scrabble_scores;

pure int value(char letter)
{
    letter |= 32;
    switch (letter)
    {
        case 'a':
        case 'e':
        case 'i':
        case 'o':
        case 'u':
        case 'l':
        case 'n':
        case 'r':
        case 's':
        case 't':
            return 1;
        case 'd':
        case 'g':
            return 2;
        case 'b':
        case 'c':
        case 'm':
        case 'p':
            return 3;
        case 'f':
        case 'h':
        case 'v':
        case 'w':
        case 'y':
            return 4;
        case 'k':
            return 5;
        case 'j':
        case 'x':
            return 8;
        case 'q':
        case 'z':
            return 10;
        default:
            return 0;
    }
}

pure int score(immutable string word)
{
    int result = 0;
    foreach (char c; word)
    {
        result += value(c);
    }
    return result;
}

unittest
{
    immutable int allTestsEnabled = 0;

    // Lowercase letter
    assert(score("a") == 1);

    static if (allTestsEnabled)
    {
        // Uppercase letter
        assert(score("A") == 1);

        // Valuable letter
        assert(score("f") == 4);

        // Short word
        assert(score("at") == 2);
        
        // Short, valuable word
        assert(score("zoo") == 12);
        
        // Medium word
        assert(score("street") == 6);
        
        // Medium, valuable word
        assert(score("quirky") == 22);
        
        // Long, mixed-case word
        assert(score("OxyphenButazone") == 41);
        
        // English-like word
        assert(score("pinata") == 8);
        
        // Empty input
        assert(score("") == 0);
        
        // Entire alphabet available
        assert(score("abcdefghijklmnopqrstuvwxyz") == 87);
    }
}