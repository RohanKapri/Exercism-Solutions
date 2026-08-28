USING: combinators formatting kernel ranges sequences ;
IN: twelve-days

CONSTANT: ordinals { f "first" "second" "third" "fourth" "fifth" "sixth" "seventh" "eighth" "ninth" "tenth" "eleventh" "twelfth" }

CONSTANT: gifts "twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."

CONSTANT: table { f 235 213 194 174 157 137 113 90 69 48 26 0 }

: recite-verse ( verse -- line )
    [
        ordinals nth
    ]
    [
        table nth
        gifts swap tail
    ]
    bi
    "On the %s day of Christmas my true love gave to me: %s" sprintf ;

: recite ( start end -- lines )
    [a..b]
    [
        recite-verse
    ]
    map ;