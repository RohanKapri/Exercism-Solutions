public function anagrams(string word, string[] candidates) returns string[] {
    string sortedWord = sortCharacters(word.toLowerAscii());
    string[] anagramSet = [];

    foreach string candidate in candidates {
        string sortedCandidate = sortCharacters(candidate.toLowerAscii());
        if (sortedCandidate == sortedWord && !isSameIgnoringCase(candidate, word)) {
            anagramSet.push(candidate);
        }
    }

    return anagramSet;
}

function sortCharacters(string s) returns string {
    int[] codePoints = s.toCodePointInts();
    int[] sortedCodePoints = codePoints.sort();
    return fromCodePointIntsToString(sortedCodePoints);
}

function isSameIgnoringCase(string s1, string s2) returns boolean {
    return s1.toLowerAscii() == s2.toLowerAscii();
}

function fromCodePointIntsToString(int[] codePoints) returns string {
    string result = "";
    foreach int codePoint in codePoints {
        string|error c = 'string:fromCodePointInt(codePoint);
        if c is string {
            result += c;
        }
    }
    return result;
}