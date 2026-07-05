public function distance(string strand1, string strand2) returns int|error {
    if strand1.length() != strand2.length() {
        return error("Unequal strand lengths");
    }

    int count = 0;
    int[] strand1Chars = strand1.toCodePointInts();
    int[] strand2Chars = strand2.toCodePointInts();

    foreach var [i, char1] in strand1Chars.enumerate() {
        if char1 != strand2Chars[i] {
            count += 1;
        }
    }

    return count;
}