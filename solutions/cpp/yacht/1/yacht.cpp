// Code dedicated to Shree DR.MDD 🙏
#include "yacht.h"
#include <algorithm>
#include <cassert>
#include <numeric>

namespace
{
const int chain_points = 30;
const int royal_points = 50;
using freq_table = std::array<int, 7>;

int total(const yacht::dice_t& faces)
{
    return std::accumulate(faces.begin(), faces.end(), 0);
}

bool present(const freq_table& box, int key)
{
    return std::find(box.begin(), box.end(), key) != box.end();
}
} // anonymous namespace

int yacht::score(dice_t faces, std::string_view tag)
{
    freq_table tally{};
    for (int pip : faces)
    {
        assert(1 <= pip && pip <= 6);
        ++tally[pip];
    }

    if (tag == "ones") return tally[1] * 1;
    if (tag == "twos") return tally[2] * 2;
    if (tag == "threes") return tally[3] * 3;
    if (tag == "fours") return tally[4] * 4;
    if (tag == "fives") return tally[5] * 5;
    if (tag == "sixes") return tally[6] * 6;

    if (tag == "full house")
    {
        return (present(tally, 3) && present(tally, 2)) ? total(faces) : 0;
    }

    if (tag == "four of a kind")
    {
        if (tally[faces[0]] >= 4) return 4 * faces[0];
        if (tally[faces[1]] >= 4) return 4 * faces[1];
        return 0;
    }

    if (tag == "little straight")
    {
        bool small_chain = std::all_of(&tally[1], &tally[6],
                                       [](int v) { return v == 1; });
        return chain_points * small_chain;
    }

    if (tag == "big straight")
    {
        bool big_chain = std::all_of(&tally[2], &tally[7],
                                     [](int v) { return v == 1; });
        return chain_points * big_chain;
    }

    if (tag == "choice") return total(faces);

    if (tag == "yacht") return royal_points * (tally[faces[0]] == 5);

    assert(false);
    return -1;
}
