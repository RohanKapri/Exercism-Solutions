module line_up;

import std.conv : to;

pure string format(immutable string name, uint number)
{
    string suffix = "th";

    uint lastTwo = number % 100;

    if (lastTwo < 11 || lastTwo > 13)
    {
        switch (number % 10)
        {
            case 1:
                suffix = "st";
                break;

            case 2:
                suffix = "nd";
                break;

            case 3:
                suffix = "rd";
                break;

            default:
                break;
        }
    }

    return name ~
           ", you are the " ~
           number.to!string ~
           suffix ~
           " customer we serve today. Thank you!";
}