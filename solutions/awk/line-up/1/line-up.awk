function ordinal(n, mod100, mod10) {
    mod100 = n % 100
    if (mod100 >= 11 && mod100 <= 13)
        return n "th"

    mod10 = n % 10
    if (mod10 == 1) return n "st"
    if (mod10 == 2) return n "nd"
    if (mod10 == 3) return n "rd"
    return n "th"
}

{
    print $1 ", you are the " ordinal($2) " customer we serve today. Thank you!"
}