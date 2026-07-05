public function isPangram(string sentence) returns boolean {
    string lower = sentence.toLowerAscii();
    string[] alphabet = "abcdefghijklmnopqrstuvwxyz".toCodePointInts().map(function (int i) returns string {
        string|error c = 'string:fromCodePointInt(i);
        if c is string {
            return c;
        } else {
            return "";
        }
    });

    return alphabet.every(function (string c) returns boolean {
        return lower.indexOf(c) != ();
    });
}