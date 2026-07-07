module twelve_days;

import std.string : format;
import std.conv : to;
import std.array : join;

private pure string getOrdinal(int day)
{
    switch (day)
    {
        case 1: return "first";
        case 2: return "second";
        case 3: return "third";
        case 4: return "fourth";
        case 5: return "fifth";
        case 6: return "sixth";
        case 7: return "seventh";
        case 8: return "eighth";
        case 9: return "ninth";
        case 10: return "tenth";
        case 11: return "eleventh";
        case 12: return "twelfth";
        default: throw new Exception("Invalid day");
    }
}

private pure string getGift(int day)
{
    switch (day)
    {
        case 1: return "a Partridge in a Pear Tree";
        case 2: return "two Turtle Doves";
        case 3: return "three French Hens";
        case 4: return "four Calling Birds";
        case 5: return "five Gold Rings";
        case 6: return "six Geese-a-Laying";
        case 7: return "seven Swans-a-Swimming";
        case 8: return "eight Maids-a-Milking";
        case 9: return "nine Ladies Dancing";
        case 10: return "ten Lords-a-Leaping";
        case 11: return "eleven Pipers Piping";
        case 12: return "twelve Drummers Drumming";
        default: throw new Exception("Invalid day");
    }
}

private pure string getVerse(int day)
{
    string[] gifts;
    for (int i = day; i >= 1; i--)
    {
        if (i == 1 && day > 1)
        {
            gifts ~= "and " ~ getGift(i);
        }
        else
        {
            gifts ~= getGift(i);
        }
    }
    
    return format("On the %s day of Christmas my true love gave to me: %s.",
                 getOrdinal(day),
                 gifts.join(", "));
}

pure string recite(int startVerse, int endVerse)
{
    string[] verses;
    for (int i = startVerse; i <= endVerse; i++)
    {
        verses ~= getVerse(i);
    }
    return verses.join("\n");
}

unittest
{
    immutable int allTestsEnabled = 0;

    // Verse-first day a partridge in a pear tree
    {
        string expected =
            "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.";
        assert(recite(1, 1) == expected);
    }

    static if (allTestsEnabled)
    {
        // Verse-second day two turtle doves
        {
            string expected =
                "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.";
            assert(recite(2, 2) == expected);
        }

        // Verse-third day three french hens
        {
            string expected =
                "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.";
            assert(recite(3, 3) == expected);
        }

        // Verse-fourth day four calling birds
        {
            string expected =
                "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.";
            assert(recite(4, 4) == expected);
        }

        // Verse-fifth day five gold rings
        {
            string expected =
                "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.";
            assert(recite(5, 5) == expected);
        }

        // Verse-sixth day six geese-a-laying
        {
            string expected =
                "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.";
            assert(recite(6, 6) == expected);
        }

        // Verse-seventh day seven swans-a-swimming
        {
            string expected =
                "On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.";
            assert(recite(7, 7) == expected);
        }

        // Verse-eighth day eight maids-a-milking
        {
            string expected =
                "On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.";
            assert(recite(8, 8) == expected);
        }

        // Verse-ninth day nine ladies dancing
        {
            string expected =
                "On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.";
            assert(recite(9, 9) == expected);
        }

        // Verse-tenth day ten lords-a-leaping
        {
            string expected =
                "On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.";
            assert(recite(10, 10) == expected);
        }

        // Verse-eleventh day eleven pipers piping
        {
            string expected =
                "On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.";
            assert(recite(11, 11) == expected);
        }

        // Verse-twelfth day twelve drummers drumming
        {
            string expected =
                "On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.";
            assert(recite(12, 12) == expected);
        }

        // Lyrics-recites first three verses of the song
        {
            string expected =
                "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.\n" ~
                "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.\n" ~
                "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.";
            assert(recite(1, 3) == expected);
        }

        // Lyrics-recites three verses from the middle of the song
        {
            string expected =
                "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n" ~
                "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n" ~
                "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.";
            assert(recite(4, 6) == expected);
        }

        // Lyrics-recites the whole song
        {
            string expected =
                "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.\n" ~
                "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.\n" ~
                "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n" ~
                "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n" ~
                "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n" ~
                "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n" ~
                "On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n" ~
                "On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n" ~
                "On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n" ~
                "On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n" ~
                "On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.\n" ~
                "On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.";
            assert(recite(1, 12) == expected);
        }
    }
}