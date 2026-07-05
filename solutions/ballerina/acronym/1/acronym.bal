# Returns the acronym of the given phrase.
#
# + phrase - a string
# + return - the acronym
function abbreviate(string phrase) returns string {
    return string:'join("", ...re `[\s\-_]+`.split(phrase).map(word => word[0].toUpperAscii()));
}