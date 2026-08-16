USING: hash-sets kernel locals math math.bitwise ranges sequences sets ;
IN: allergies

CONSTANT: items { "eggs" "peanuts" "shellfish" "strawberries" "tomatoes" "chocolate" "pollen" "cats" }

:: allergic-to ( score item -- ? )
    1
    item items index
    shift score bitand
    0 > ;

:: allergens ( score -- set )
    HS{ } clone :> result

    0 7 [a..b]
    [| index |
        1 index shift score bitand 0 =
        [
            index items nth result adjoin
        ]
        unless
    ]
    each

    result ;