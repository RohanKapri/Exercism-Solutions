import ballerina/io;

public function transform(map<string[]> old) returns map<int> {
    map<int> newMap = {};
    foreach var [scoreStr, letters] in old.entries() {
        int score = checkpanic int:fromString(scoreStr);
        foreach string letter in letters {
            string lowerCaseLetter = letter.toLowerAscii();
            newMap[lowerCaseLetter] = score;
        }
    }
    return newMap;
}

public function main() {
    map<string[]> input = {
        "1": ["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"],
        "2": ["D", "G"],
        "3": ["B", "C", "M", "P"],
        "4": ["F", "H", "V", "W", "Y"],
        "5": ["K"],
        "8": ["J", "X"],
        "10": ["Q", "Z"]
    };

    map<int> result = transform(input);
    io:println(result);
}