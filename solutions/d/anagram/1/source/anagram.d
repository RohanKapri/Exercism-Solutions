module anagram;

import std.algorithm : sort;
import std.array : array;
import std.string : toLower;

pure string[] findAnagrams(immutable string subject, immutable string[] candidates)
{
    string[] result;

    auto subjectLower = toLower(subject);
    auto subjectSorted = array(subjectLower);
    sort(subjectSorted);

    foreach (candidate; candidates)
    {
        auto candidateLower = toLower(candidate);

        if (candidateLower == subjectLower)
            continue;

        if (candidateLower.length != subjectLower.length)
            continue;

        auto candidateSorted = array(candidateLower);
        sort(candidateSorted);

        if (candidateSorted == subjectSorted)
            result ~= candidate;
    }

    return result;
}