module allergies;

class Allergies
{
    private uint score;

    private enum string[] items =
    [
        "eggs",
        "peanuts",
        "shellfish",
        "strawberries",
        "tomatoes",
        "chocolate",
        "pollen",
        "cats"
    ];

    this(immutable uint score)
    {
        this.score = score & 255;
    }

    final bool allergicTo(immutable string item)
    {
        foreach (i, allergen; items)
        {
            if (allergen == item)
            {
                return (score & (1u << i)) != 0;
            }
        }
        return false;
    }

    final string[] list()
    {
        string[] result;

        foreach (i, allergen; items)
        {
            if ((score & (1u << i)) != 0)
            {
                result ~= allergen;
            }
        }

        return result;
    }
}