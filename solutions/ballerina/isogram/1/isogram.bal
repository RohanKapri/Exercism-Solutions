import ballerina/regex;

public function isIsogram(string sentence) returns boolean {
    string cleaned = regex:replaceAll(sentence, "[\\W]+","").toLowerAscii();
    int len = cleaned.length();
    map<boolean> mem = {};

    foreach int code in cleaned.toCodePointInts() {
        mem[code.toString()] = true;
    }

    return mem.length() == len;
}