module resistor_color_trio;

import std.conv : to;

class ResistorColorTrio
{
    static string label(string[] colors)
    {
        immutable int[string] value =
        [
            "black"  : 0,
            "brown"  : 1,
            "red"    : 2,
            "orange" : 3,
            "yellow" : 4,
            "green"  : 5,
            "blue"   : 6,
            "violet" : 7,
            "grey"   : 8,
            "white"  : 9
        ];

        ulong resistance = cast(ulong)(value[colors[0]] * 10 + value[colors[1]]);

        foreach (_; 0 .. value[colors[2]])
            resistance *= 10;

        if (resistance >= 1_000_000_000 && resistance % 1_000_000_000 == 0)
            return (resistance / 1_000_000_000).to!string ~ " gigaohms";

        if (resistance >= 1_000_000 && resistance % 1_000_000 == 0)
            return (resistance / 1_000_000).to!string ~ " megaohms";

        if (resistance >= 1_000 && resistance % 1_000 == 0)
            return (resistance / 1_000).to!string ~ " kiloohms";

        return resistance.to!string ~ " ohms";
    }
}