function isPaired(string value) returns boolean {
    string[] stack = [];
    map<string> matchingBrackets = {
        "}": "{",
        "]": "[",
        ")": "("
    };
    
    foreach string c in value {
        if c == "{" || c == "[" || c == "(" {
            stack.push(c);
        } else if c == "}" || c == "]" || c == ")" {
            if stack.length() == 0 || stack.pop() != matchingBrackets[c] {
                return false;
            }
        }
    }
    
    return stack.length() == 0;
}