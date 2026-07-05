# Calculates the resistor value for the passed band colors
#
# + colors - The colors of the resistor bands
# + return - The value of the resistor bands
function value(string[] colors) returns int {
    map<int> colorCodes = {
        "black": 0,
        "brown": 1,
        "red": 2,
        "orange": 3,
        "yellow": 4,
        "green": 5,
        "blue": 6,
        "violet": 7,
        "grey": 8,
        "white": 9
    };

    int[] digits = [];
    foreach var color in colors {
        int? digit = colorCodes[color];
        if digit is int {
            digits.push(digit);
        }
        if digits.length() == 2 {
            break;
        }
    }

    int first = digits.length() > 0 ? digits[0] : 0;
    int second = digits.length() > 1 ? digits[1] : 0;

    return first * 10 + second;
}
             