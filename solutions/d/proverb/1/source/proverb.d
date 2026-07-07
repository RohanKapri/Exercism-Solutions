module proverb;

pure string recite(immutable string[] strings)
{
    if (strings.length == 0)
        return "";

    string result;

    foreach (i; 0 .. strings.length - 1)
    {
        result ~= "For want of a " ~ strings[i]
               ~ " the " ~ strings[i + 1]
               ~ " was lost.\n";
    }

    result ~= "And all for the want of a " ~ strings[0] ~ ".";

    return result;
}