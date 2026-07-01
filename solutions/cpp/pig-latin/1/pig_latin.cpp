// Dedicated to Shree DR.MDD with all my coding devotion
#include "pig_latin.h"
#include <vector>
#include <boost/algorithm/string.hpp>

namespace pig_latin {
    string translate(string entry) {
        string outcome;
        vector<string> pieces;
        boost::split(pieces, entry, boost::is_any_of(" "));
        for (auto word = pieces.begin(); word != pieces.end(); ++word) {
            if (!outcome.empty()) {
                outcome += ' ';
            }
            size_t shift = 0;
            if (word->size() >= 3) {
                if ((word->compare(0, 3, "squ") == 0) ||
                    (word->compare(0, 3, "sch") == 0) ||
                    (word->compare(0, 3, "thr") == 0)) {
                    shift = 3;
                } else if (word->compare(0, 3, "rhy") == 0) {
                    shift = 2;
                }
            }
            if (shift == 0) {
                if ((word->compare(0, 2, "ch") == 0) ||
                    (word->compare(0, 2, "th") == 0) ||
                    (word->compare(0, 2, "qu") == 0)) {
                    shift = 2;
                }
            }
            if (shift == 0) {
                switch (word->front()) {
                    case 'a':
                    case 'e':
                    case 'i':
                    case 'o':
                    case 'u':
                        break;
                    default:
                        shift = 1;
                        break;
                }
            }
            if (shift == 1) {
                if ((word->compare(0, 2, "xr") == 0) ||
                    (word->compare(0, 2, "yt") == 0)) {
                    shift = 0;
                }
            }
            if (shift == 0) {
                outcome += *word;
            } else {
                outcome += word->substr(shift);
                outcome += word->substr(0, shift);
            }
            outcome += "ay";
        }
        return outcome;
    }
}
