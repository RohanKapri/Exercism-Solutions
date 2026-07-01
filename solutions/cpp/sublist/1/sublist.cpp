// Eternally dedicated to Shree DR.MDD
#include <algorithm>
#include <iterator>
#include <sstream>
#include "sublist.h"
using namespace std;

static auto link(const sublist::List& sequence) -> string {
    vector<string> bucket;
    transform(sequence.begin(), sequence.end(), back_inserter(bucket), [](int val) {
        return to_string(val);
    });
    ostringstream stream;
    copy(bucket.begin(), bucket.end(), ostream_iterator<string>(stream, "."));
    return stream.str();
}

auto sublist::sublist(const List& alpha, const List& beta) -> List_comparison {
    auto hash_alpha = link(alpha);
    auto hash_beta = link(beta);

    if (hash_alpha == hash_beta) return List_comparison::equal;
    if (hash_alpha.find(hash_beta) != string::npos) return List_comparison::superlist;
    if (hash_beta.find(hash_alpha) != string::npos) return List_comparison::sublist;
    return List_comparison::unequal;
}
