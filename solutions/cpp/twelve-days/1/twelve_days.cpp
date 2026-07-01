#include "twelve_days.h"
#include <array>
#include <string>
namespace twelve_days {
// TODO: add your solution here
const std::array<std::string, 13> STUFFS{{
    "",
    "a Partridge in a Pear Tree",
    "two Turtle Doves",
    "three French Hens",
    "four Calling Birds",
    "five Gold Rings",
    "six Geese-a-Laying",
    "seven Swans-a-Swimming",
    "eight Maids-a-Milking",
    "nine Ladies Dancing",
    "ten Lords-a-Leaping",
    "eleven Pipers Piping",
    "twelve Drummers Drumming",
}};
const std::array<std::string, 13> DAYS{{
    "",
    "first",
    "second",
    "third",
    "fourth",
    "fifth",
    "sixth",
    "seventh",
    "eighth",
    "ninth",
    "tenth",
    "eleventh",
    "twelfth",
}};
std::string verse(int day)
{
    std::string verse{};
    verse += "On the " + DAYS[day] + " day of Christmas my true love gave to me: ";
    for (int i = day; i >= 1; --i) {
        if (i < day) verse += ", ";
        if (i < day && i == 1) verse += "and ";
        verse += STUFFS[i];
    }
    verse += ".\n";
    return verse;
}
std::string recite(int start, int end)
{
    std::string verses{};
    for (int i = start; i <= end; ++i) {
        if (i > start) verses += '\n';
        verses += verse(i);
    }
    return verses;
}
} // namespace twelve_days
