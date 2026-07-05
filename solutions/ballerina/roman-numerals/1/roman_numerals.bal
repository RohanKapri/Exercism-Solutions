# Convert an integer to a Roman number.
#
# + number - the integer to convert
# + return - the Roman number as a string
function roman(int number) returns string {
    int[] values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
    string[] numerals = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];

    string result = "";
    int num = number;

    foreach int i in 0 ..< values.length() {
        while (num >= values[i]) {
            num -= values[i];
            result += numerals[i];
        }
    }

    return result;
}