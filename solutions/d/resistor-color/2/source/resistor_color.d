module resistor_color;

class ResistorColor {
    static string[] colors = [
                "black", "brown", "red", "orange", "yellow", "green", "blue",
                "violet", "grey", "white"
                ];

    static int colorCode(string name) {
        for (int i = 0; i < 10; ++i) {
            if (colors[i] == name) {
                return i;
            }
        }
        return -1;
    }
};


unittest
{
    immutable int allTestsEnabled = 0;

    // Black
    assert(ResistorColor.colorCode("black") == 0);

    static if (allTestsEnabled)
    {
        // White
        assert(ResistorColor.colorCode("white") == 9);

        // Orange
        assert(ResistorColor.colorCode("orange") == 3);

        // Colors
        assert(ResistorColor.colors == [
                "black", "brown", "red", "orange", "yellow", "green", "blue",
                "violet", "grey", "white"
                ]);
    }

}