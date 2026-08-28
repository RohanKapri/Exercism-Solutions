USING: arrays combinators kernel math sequences ;
IN: roman-numerals

CONSTANT: thousands { "" "M" "MM" "MMM" "MMM" }

CONSTANT: hundreds { "" "C" "CC" "CCC" "CD" "D" "DC" "DCC" "DCCC" "CM" }

CONSTANT: tens { "" "X" "XX" "XXX" "XL" "L" "LX" "LXX" "LXXX" "XC" }

CONSTANT: units { "" "I" "II" "III" "IV" "V" "VI" "VII" "VIII" "IX" }

: roman ( n -- str )
    1000 /mod
    [
        thousands nth
    ]
    dip

    100 /mod
    [
        hundreds nth
    ]
    dip

    10 /mod
    [
        tens nth
    ]
    dip

    units nth

    4array concat ;