final string[] COLOR_CODES = [
    "black",
    "brown",
    "red",
    "orange",
    "yellow",
    "green",
    "blue",
    "violet",
    "grey",
    "white"
];

# Calculates the resistor value for the passed band color
#
# + color - The color of the resistor band
# + return - The value of the resistor band
function colorCode(string color) returns int {
    int index = 0;
    foreach string colorCodeValue in COLOR_CODES {
        if colorCodeValue == color {
            return index;
        }
        index += 1;
    }

    return -1;
}

# Returns the list of colors in the resistor color code
# + return - The list of colors
function colors() returns string[] {
    return COLOR_CODES;
}