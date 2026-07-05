const int ASCII_A = 97;
const int ASCII_Z = 122;
const int ASCII_0 = 48;
const int ASCII_9 = 57;

public function encode(string phrase) returns string {
    string normalized = phrase.toLowerAscii();
    string result = "";
    int processedCount = 0;

    foreach int codePoint in normalized.toCodePointInts() {
        string? transformed = transform(codePoint);
        if transformed is () {
            continue;
        }

        if processedCount > 0 && processedCount % 5 == 0 {
            result += " ";
        }

        result += transformed;
        processedCount += 1;
    }

    return result;
}

public function decode(string phrase) returns string {
    string normalized = phrase.toLowerAscii();
    string result = "";

    foreach int codePoint in normalized.toCodePointInts() {
        string? transformed = transform(codePoint);
        if transformed is () {
            continue;
        }
        result += transformed;
    }

    return result;
}

function transform(int codePoint) returns string? {
    if codePoint >= ASCII_A && codePoint <= ASCII_Z {
        int offset = codePoint - ASCII_A;
        int mapped = ASCII_Z - offset;
        string|error transformed = 'string:fromCodePointInt(mapped);
        if transformed is string {
            return transformed;
        }
        return ();
    } else if codePoint >= ASCII_0 && codePoint <= ASCII_9 {
        string|error digit = 'string:fromCodePointInt(codePoint);
        if digit is string {
            return digit;
        }
        return ();
    }

    return ();
}