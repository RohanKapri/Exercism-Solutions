module say;

private enum string[] ONES  = [
    "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"
];

private enum string[] TEENS = [
    "ten", "eleven", "twelve", "thirteen", "fourteen",
    "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"
];

private enum string[] TENS  = [
    "", "", "twenty", "thirty", "forty", "fifty",
    "sixty", "seventy", "eighty", "ninety"
];

/// Convert 1..99 to words (no leading/trailing spaces).
pure @safe string twoDigitsToWords(int n)
{
    // pre: 1 <= n <= 99
    if (n < 10)           return ONES[n];
    if (n < 20)           return TEENS[n - 10];
    const t = TENS[n / 10];
    const u = n % 10;
    return u == 0 ? t : t ~ "-" ~ ONES[u];
}

/// Convert 1..999 to words (no leading/trailing spaces).
pure @safe string threeDigitsToWords(int n)
{
    // pre: 1 <= n <= 999
    const h = n / 100;
    const r = n % 100;

    if (h == 0)               return twoDigitsToWords(r);
    if (r == 0)               return ONES[h] ~ " hundred";
    else                      return ONES[h] ~ " hundred " ~ twoDigitsToWords(r);
}

pure string say(long number)
{
    import std.array : array, join;

    // Range check
    enum long MAX = 999_999_999_999L;
    if (number < 0 || number > MAX)
        throw new Exception("out of range");

    // Zero is special
    if (number == 0)
        return "zero";

    // Break into 3-digit chunks
    enum long BILLION  = 1_000_000_000L;
    enum long MILLION  = 1_000_000L;
    enum long THOUSAND = 1_000L;

    string[] parts;
    parts.reserve(4);

    auto emit = (long chunk, string scale)
    {
        if (chunk == 0) return;
        // chunk fits into int (it’s <= 999)
        parts ~= threeDigitsToWords(cast(int) chunk) ~ (scale.length ? " " ~ scale : "");
    };

    const b = (number / BILLION) % 1000;
    const m = (number / MILLION) % 1000;
    const t = (number / THOUSAND) % 1000;
    const r =  number % 1000;

    emit(b, "billion");
    emit(m, "million");
    emit(t, "thousand");
    if (r != 0) emit(r, "");

    return parts.join(" ");
}

unittest
{
    import std.algorithm.comparison : equal;
    import std.exception : assertThrown;

    immutable int allTestsEnabled = 0;

    // Zero
    assert(equal("zero",
                 say(0L)));

    static if (allTestsEnabled)
    {
        // One
        assert(equal("one",
                     say(1L)));

        // Fourteen
        assert(equal("fourteen",
                     say(14L)));

        // Twenty
        assert(equal("twenty",
                     say(20L)));

        // Twenty-two
        assert(equal("twenty-two",
                     say(22L)));

        // Thirty
        assert(equal("thirty",
                     say(30L)));

        // Ninety-nine
        assert(equal("ninety-nine",
                     say(99L)));

        // One hundred
        assert(equal("one hundred",
                     say(100L)));

        // One hundred twenty-three
        assert(equal("one hundred twenty-three",
                     say(123L)));

        // Two hundred
        assert(equal("two hundred",
                     say(200L)));

        // Nine hundred ninety-nine
        assert(equal("nine hundred ninety-nine",
                     say(999L)));

        // One thousand
        assert(equal("one thousand",
                     say(1000L)));

        // One thousand two hundred thirty-four
        assert(equal("one thousand two hundred thirty-four",
                     say(1234L)));

        // One million
        assert(equal("one million",
                     say(1000000L)));

        // One million two thousand three hundred forty-five
        assert(equal("one million two thousand three hundred forty-five",
                     say(1002345L)));

        // One billion
        assert(equal("one billion",
                     say(1000000000L)));

        // A big number
        assert(equal("nine hundred eighty-seven billion six hundred fifty-four million three hundred twenty-one thousand one hundred twenty-three",
                     say(987654321123L)));

        // Numbers below zero are out of range
        assertThrown(say(-1L));

        // Numbers above 999,999,999,999 are out of range
        assertThrown(say(1000000000000L));
    }
}
                         