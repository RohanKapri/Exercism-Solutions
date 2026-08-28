module house;

import std.algorithm : map;
import std.array : join;
import std.range : iota;

pure string recite(int startVerse, int endVerse)
{
    // Define the subjects and actions for each verse
    immutable string[] subjects = [
        "house that Jack built",
        "malt",
        "rat",
        "cat",
        "dog",
        "cow with the crumpled horn",
        "maiden all forlorn",
        "man all tattered and torn",
        "priest all shaven and shorn",
        "rooster that crowed in the morn",
        "farmer sowing his corn",
        "horse and the hound and the horn"
    ];

    immutable string[] actions = [
        "lay in",
        "ate",
        "killed",
        "worried",
        "tossed",
        "milked",
        "kissed",
        "married",
        "woke",
        "kept",
        "belonged to"
    ];

    // Function to build a single verse
    string buildVerse(int verseNumber)
    {
        string verse = "This is the " ~ subjects[verseNumber - 1];
        
        // Add each previous part of the rhyme
        for (int i = verseNumber - 1; i > 0; i--)
        {
            verse ~= " that " ~ actions[i - 1] ~ " the " ~ subjects[i - 1];
        }
        
        verse ~= ".";
        return verse;
    }

    // Build all requested verses
    auto verses = iota(startVerse, endVerse + 1)
                  .map!(i => buildVerse(i))
                  .join("\n");
    
    return verses;
}

unittest
{
    immutable int allTestsEnabled = 0;

    // Verse one - the house that jack built
    {
        string expected =
            "This is the house that Jack built.";
        assert(recite(1, 1) == expected);
    }

    static if (allTestsEnabled)
    {
        // Verse two - the malt that lay
        {
            string expected =
                "This is the malt that lay in the house that Jack built.";
            assert(recite(2, 2) == expected);
        }

        // Verse three - the rat that ate
        {
            string expected =
                "This is the rat that ate the malt that lay in the house that Jack built.";
            assert(recite(3, 3) == expected);
        }

        // Verse four - the cat that killed
        {
            string expected =
                "This is the cat that killed the rat that ate the malt that lay in the house that Jack built.";
            assert(recite(4, 4) == expected);
        }

        // Verse five - the dog that worried
        {
            string expected =
                "This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.";
            assert(recite(5, 5) == expected);
        }

        // Verse six - the cow with the crumpled horn
        {
            string expected =
                "This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.";
            assert(recite(6, 6) == expected);
        }

        // Verse seven - the maiden all forlorn
        {
            string expected =
                "This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.";
            assert(recite(7, 7) == expected);
        }

        // Verse eight - the man all tattered and torn
        {
            string expected =
                "This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.";
            assert(recite(8, 8) == expected);
        }

        // Verse nine - the priest all shaven and shorn
        {
            string expected =
                "This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.";
            assert(recite(9, 9) == expected);
        }

        // Verse 10 - the rooster that crowed in the morn
        {
            string expected =
                "This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.";
            assert(recite(10, 10) == expected);
        }

        // Verse 11 - the farmer sowing his corn
        {
            string expected =
                "This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.";
            assert(recite(11, 11) == expected);
        }

        // Verse 12 - the horse and the hound and the horn
        {
            string expected =
                "This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.";
            assert(recite(12, 12) == expected);
        }

        // Multiple verses
        {
            string expected =
                "This is the cat that killed the rat that ate the malt that lay in the house that Jack built.\n" ~
                "This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n" ~
                "This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n" ~
                "This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n" ~
                "This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.";
            assert(recite(4, 8) == expected);
        }

        // Full rhyme
        {
            string expected =
                "This is the house that Jack built.\n" ~
                "This is the malt that lay in the house that Jack built.\n" ~
                "This is the rat that ate the malt that lay in the house that Jack built.\n" ~
                "This is the cat that killed the rat that ate the malt that lay in the house that Jack built.\n" ~
                "This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n" ~
                "This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n" ~
                "This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n" ~
                "This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n" ~
                "This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n" ~
                "This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n" ~
                "This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n" ~
                "This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.";
            assert(recite(1, 12) == expected);
        }
    }
}