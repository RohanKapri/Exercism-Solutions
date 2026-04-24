BEGIN {
    FPAT = "[[:digit:]]+|[[:alpha:]]+('[[:alpha:]]+)?"
    OFS = ": "
}
{
    for (i = 1; i <= NF; ++i) Words[tolower($i)]++
}
END {
    for (word in Words) print word, Words[word]
}