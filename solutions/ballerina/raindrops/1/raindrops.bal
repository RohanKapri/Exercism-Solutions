public function convert(int n) returns string {
    string result = "";

    if (n % 3 == 0) {
        result += "Pling";
    }
    if (n % 5 == 0) {
        result += "Plang";
    }
    if (n % 7 == 0) {
        result += "Plong";
    }

    if (result == "") {
        result = n.toString();
    }

    return result;
}