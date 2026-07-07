module grains;

import std.exception : enforce;

pure ulong square(immutable ulong num)
{
    enforce(num >= 1 && num <= 64, "Invalid square number");

    return 1uL << (num - 1);
}

pure ulong total()
{
    return ulong.max;
}