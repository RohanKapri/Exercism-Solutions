using System.Runtime.InteropServices.ComTypes;

public static class LineUp
{
    public static string Format(string name, int number) =>
        $"{name}, you are the {Formatted(number)} customer we serve today. Thank you!";

    private static string Formatted(int number) =>
        $"{number}{Suffix(number)}";

    private static string Suffix(int number) =>
        (number % 10, number % 100) switch
        {
            (_, 11) => "th",
            (_, 12) => "th",
            (_, 13) => "th",
            (1, _) => "st",
            (2, _) => "nd",
            (3, _) => "rd",
            _ => "th"
        };
}