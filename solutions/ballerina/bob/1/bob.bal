# Returns Bob's response to someone talking to him.
#
# + input - whatever is said to Bob
# + return - Bob's response
public function hey(string input) returns string {
    string trimmedInput = input.trim();
    if (trimmedInput.length() == 0) {
        return "Fine. Be that way!";
    } else if (trimmedInput.toUpperAscii() == trimmedInput && trimmedInput.toLowerAscii() != trimmedInput) {
        if (trimmedInput.endsWith("?")) {
            return "Calm down, I know what I'm doing!";
        } else {
            return "Whoa, chill out!";
        }
    } else if (trimmedInput.endsWith("?")) {
        return "Sure.";
    } else {
        return "Whatever.";
    }
}