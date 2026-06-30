module alphametics;

import std.algorithm.comparison : max;
import std.exception : enforce;

enum ubyte UNASSIGNED = 255;

struct Column
{
    ubyte[] addends;
    ubyte result;
}

struct Puzzle
{
    ubyte[] letters;
    ubyte[256] letterIndex;
    bool[256] leading;
    Column[] columns;
    ubyte[] assign;
}

pure string solve(immutable string puzzle)
{
    Puzzle p;
    parsePuzzle(puzzle, p);
    if (!search(p, 0))
        throw new Exception("No solution");
    return substitute(puzzle, p.assign, p.letterIndex);
}

private pure void parsePuzzle(immutable string puzzle, ref Puzzle p)
{
    p.letterIndex[] = 255;

    immutable(string)[] addends;
    string result;

    size_t i;
    while (i < puzzle.length)
    {
        while (i < puzzle.length && puzzle[i] == ' ')
            i++;
        if (i >= puzzle.length)
            break;

        immutable start = i;
        while (i < puzzle.length && puzzle[i] != ' ')
            i++;
        immutable word = puzzle[start .. i];

        while (i < puzzle.length && puzzle[i] == ' ')
            i++;
        if (i >= puzzle.length)
        {
            result = word;
            break;
        }

        if (i + 2 <= puzzle.length && puzzle[i .. i + 2] == "==")
        {
            addends ~= word;
            i += 2;
            while (i < puzzle.length && puzzle[i] == ' ')
                i++;
            enforce(i < puzzle.length, "Invalid puzzle");
            immutable rStart = i;
            while (i < puzzle.length && puzzle[i] != ' ')
                i++;
            result = puzzle[rStart .. i];
            break;
        }

        addends ~= word;
        enforce(puzzle[i] == '+', "Invalid puzzle");
        i++;
    }

    enforce(result.length != 0, "Invalid puzzle");

    bool[256] seen;
    foreach (w; addends)
    {
        if (w.length > 1)
            p.leading[w[0]] = true;
        foreach (c; w)
        {
            if (!seen[c])
            {
                seen[c] = true;
                p.letterIndex[c] = cast(ubyte) p.letters.length;
                p.letters ~= c;
            }
        }
    }
    if (result.length > 1)
        p.leading[result[0]] = true;
    foreach (c; result)
    {
        if (!seen[c])
        {
            seen[c] = true;
            p.letterIndex[c] = cast(ubyte) p.letters.length;
            p.letters ~= c;
        }
    }

    p.assign.length = p.letters.length;
    p.assign[] = UNASSIGNED;

    size_t maxLen;
    foreach (w; addends)
        maxLen = max(maxLen, w.length);
    maxLen = max(maxLen, result.length);

    p.columns.length = maxLen;
    foreach (col; 0 .. maxLen)
    {
        foreach (w; addends)
        {
            if (col < w.length)
                p.columns[col].addends ~= p.letterIndex[w[$ - 1 - col]];
        }
        if (col < result.length)
            p.columns[col].result = p.letterIndex[result[$ - 1 - col]];
        else
            p.columns[col].result = UNASSIGNED;
    }

    sortLettersByColumnWeight(p);
}

private pure void sortLettersByColumnWeight(ref Puzzle p)
{
    immutable saved = p.letters.dup;
    uint[256] weight;

    foreach (col; p.columns)
    {
        foreach (a; col.addends)
            weight[saved[a]]++;
        if (col.result != UNASSIGNED)
            weight[saved[col.result]]++;
    }

    p.letters = saved.dup;
    foreach (k; 0 .. p.letters.length)
    {
        foreach (j; k + 1 .. p.letters.length)
        {
            if (weight[p.letters[k]] < weight[p.letters[j]])
            {
                const tmp = p.letters[k];
                p.letters[k] = p.letters[j];
                p.letters[j] = tmp;
            }
        }
    }

    p.letterIndex[] = 255;
    foreach (i; 0 .. p.letters.length)
        p.letterIndex[p.letters[i]] = cast(ubyte) i;

    foreach (ref col; p.columns)
    {
        foreach (k; 0 .. col.addends.length)
            col.addends[k] = p.letterIndex[saved[col.addends[k]]];
        if (col.result != UNASSIGNED)
            col.result = p.letterIndex[saved[col.result]];
    }
}

private pure bool search(ref Puzzle p, size_t letterPos)
{
    if (letterPos == p.letters.length)
        return columnsValid(p, true);

    immutable ubyte letter = p.letters[letterPos];
    immutable bool isLeading = p.leading[letter];
    uint usedMask;

    foreach (i; 0 .. p.letters.length)
    {
        if (p.assign[i] != UNASSIGNED)
            usedMask |= 1U << p.assign[i];
    }

    foreach (d; 0 .. 10)
    {
        if (usedMask & (1U << d))
            continue;
        if (isLeading && d == 0)
            continue;

        p.assign[letterPos] = cast(ubyte) d;
        if (columnsValid(p, false) && search(p, letterPos + 1))
            return true;
        p.assign[letterPos] = UNASSIGNED;
    }
    return false;
}

private pure bool columnsValid(in Puzzle p, bool requireAllAssigned)
{
    int carry;
    foreach (col; p.columns)
    {
        int sum = carry;
        foreach (a; col.addends)
        {
            immutable v = p.assign[a];
            if (v == UNASSIGNED)
                return !requireAllAssigned;
            sum += v;
        }

        if (col.result == UNASSIGNED)
        {
            foreach (a; col.addends)
            {
                if (p.assign[a] == UNASSIGNED)
                    return !requireAllAssigned;
            }
            if (requireAllAssigned)
            {
                if (sum % 10 != 0)
                    return false;
                carry = sum / 10;
                continue;
            }
            return true;
        }

        immutable rv = p.assign[col.result];
        if (rv == UNASSIGNED)
            return !requireAllAssigned;

        if (sum % 10 != rv)
            return false;
        carry = sum / 10;
    }

    return !requireAllAssigned || carry == 0;
}

private pure string substitute(
    immutable string puzzle,
    in ubyte[] assign,
    in ubyte[256] letterIndex)
{
    char[] buf;
    buf.length = puzzle.length;
    size_t n;
    foreach (c; puzzle)
    {
        if (c >= 'A' && c <= 'Z')
            buf[n++] = cast(char)('0' + assign[letterIndex[c]]);
        else
            buf[n++] = c;
    }
    return buf[0 .. n].idup;
}

unittest
{
    import std.exception : assertThrown;

    immutable int allTestsEnabled = 0;

    assert(solve("I + BB == ILL") == "1 + 99 == 100");

    static if (allTestsEnabled)
    {
        assertThrown(solve("A == B"));
        assertThrown(solve("ACA + DD == BD"));
        assert(solve("A + A + A + A + A + A + A + A + A + A + A + B == BCC") == "9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 9 + 1 == 100");
        assert(solve("AS + A == MOM") == "92 + 9 == 101");
        assert(solve("NO + NO + TOO == LATE") == "74 + 74 + 944 == 1092");
        assert(solve("HE + SEES + THE == LIGHT") == "54 + 9449 + 754 == 10257");
        assert(solve("SEND + MORE == MONEY") == "9567 + 1085 == 10652");
        assert(solve("AND + A + STRONG + OFFENSE + AS + A + GOOD == DEFENSE") == "503 + 5 + 691208 + 2774064 + 56 + 5 + 8223 == 3474064");
        assert(solve("THIS + A + FIRE + THEREFORE + FOR + ALL + HISTORIES + I + TELL + A + TALE + THAT + FALSIFIES + ITS + TITLE + TIS + A + LIE + THE + TALE + OF + THE + LAST + FIRE + HORSES + LATE + AFTER + THE + FIRST + FATHERS + FORESEE + THE + HORRORS + THE + LAST + FREE + TROLL + TERRIFIES + THE + HORSES + OF + FIRE + THE + TROLL + RESTS + AT + THE + HOLE + OF + LOSSES + IT + IS + THERE + THAT + SHE + STORES + ROLES + OF + LEATHERS + AFTER + SHE + SATISFIES + HER + HATE + OFF + THOSE + FEARS + A + TASTE + RISES + AS + SHE + HEARS + THE + LEAST + FAR + HORSE + THOSE + FAST + HORSES + THAT + FIRST + HEAR + THE + TROLL + FLEE + OFF + TO + THE + FOREST + THE + HORSES + THAT + ALERTS + RAISE + THE + STARES + OF + THE + OTHERS + AS + THE + TROLL + ASSAILS + AT + THE + TOTAL + SHIFT + HER + TEETH + TEAR + HOOF + OFF + TORSO + AS + THE + LAST + HORSE + FORFEITS + ITS + LIFE + THE + FIRST + FATHERS + HEAR + OF + THE + HORRORS + THEIR + FEARS + THAT + THE + FIRES + FOR + THEIR + FEASTS + ARREST + AS + THE + FIRST + FATHERS + RESETTLE + THE + LAST + OF + THE + FIRE + HORSES + THE + LAST + TROLL + HARASSES + THE + FOREST + HEART + FREE + AT + LAST + OF + THE + LAST + TROLL + ALL + OFFER + THEIR + FIRE + HEAT + TO + THE + ASSISTERS + FAR + OFF + THE + TROLL + FASTS + ITS + LIFE + SHORTER + AS + STARS + RISE + THE + HORSES + REST + SAFE + AFTER + ALL + SHARE + HOT + FISH + AS + THEIR + AFFILIATES + TAILOR + A + ROOFS + FOR + THEIR + SAFE == FORTRESSES") == "9874 + 1 + 5730 + 980305630 + 563 + 122 + 874963704 + 7 + 9022 + 1 + 9120 + 9819 + 512475704 + 794 + 97920 + 974 + 1 + 270 + 980 + 9120 + 65 + 980 + 2149 + 5730 + 863404 + 2190 + 15903 + 980 + 57349 + 5198034 + 5630400 + 980 + 8633634 + 980 + 2149 + 5300 + 93622 + 903375704 + 980 + 863404 + 65 + 5730 + 980 + 93622 + 30494 + 19 + 980 + 8620 + 65 + 264404 + 79 + 74 + 98030 + 9819 + 480 + 496304 + 36204 + 65 + 20198034 + 15903 + 480 + 419745704 + 803 + 8190 + 655 + 98640 + 50134 + 1 + 91490 + 37404 + 14 + 480 + 80134 + 980 + 20149 + 513 + 86340 + 98640 + 5149 + 863404 + 9819 + 57349 + 8013 + 980 + 93622 + 5200 + 655 + 96 + 980 + 563049 + 980 + 863404 + 9819 + 120394 + 31740 + 980 + 491304 + 65 + 980 + 698034 + 14 + 980 + 93622 + 1441724 + 19 + 980 + 96912 + 48759 + 803 + 90098 + 9013 + 8665 + 655 + 96346 + 14 + 980 + 2149 + 86340 + 56350794 + 794 + 2750 + 980 + 57349 + 5198034 + 8013 + 65 + 980 + 8633634 + 98073 + 50134 + 9819 + 980 + 57304 + 563 + 98073 + 501494 + 133049 + 14 + 980 + 57349 + 5198034 + 30409920 + 980 + 2149 + 65 + 980 + 5730 + 863404 + 980 + 2149 + 93622 + 81314404 + 980 + 563049 + 80139 + 5300 + 19 + 2149 + 65 + 980 + 2149 + 93622 + 122 + 65503 + 98073 + 5730 + 8019 + 96 + 980 + 144749034 + 513 + 655 + 980 + 93622 + 51494 + 794 + 2750 + 4863903 + 14 + 49134 + 3740 + 980 + 863404 + 3049 + 4150 + 15903 + 122 + 48130 + 869 + 5748 + 14 + 98073 + 1557271904 + 917263 + 1 + 36654 + 563 + 98073 + 4150 == 5639304404");
    }
}