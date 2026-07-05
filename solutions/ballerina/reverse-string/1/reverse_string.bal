public function reverse(string str) returns string {
    string reversedStr = "";
    int n = str.length();
    foreach int i in 0 ..< n {
        reversedStr += str.substring(n - i - 1, n - i);
    }
    return reversedStr;
}