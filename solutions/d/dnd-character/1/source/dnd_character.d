module dnd_character;

import std.random : uniform;
import std.algorithm : sort;
import std.math : floor;

class DndCharacter
{
    int strength;
    int dexterity;
    int constitution;
    int intelligence;
    int wisdom;
    int charisma;
    int hitpoints;

    this()
    {
        strength = ability();
        dexterity = ability();
        constitution = ability();
        intelligence = ability();
        wisdom = ability();
        charisma = ability();

        hitpoints = 10 + modifier(constitution);
    }
}

int ability()
{
    int[] rolls;

    foreach (_; 0 .. 4)
        rolls ~= uniform(1, 7); // 1..6

    sort(rolls);

    return rolls[1] + rolls[2] + rolls[3];
}

pure int modifier(immutable int value)
{
    return cast(int)floor((value - 10) / 2.0);
}