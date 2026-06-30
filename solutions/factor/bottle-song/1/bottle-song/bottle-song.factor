USING: arrays formatting kernel locals math sequences unicode ;
IN: bottle-song

CONSTANT: numbers { "no" "one" "two" "three" "four" "five" "six" "seven" "eight" "nine" "ten" }

: bottles ( n -- str )
    1 =
    [ "bottle" ] [ "bottles" ] if ;

: first-line ( n -- line )
    [ numbers nth capitalize ] [ bottles ] bi
    "%s green %s hanging on the wall," sprintf ;

: fourth-line ( n -- line )
    1 - [ numbers nth ] [ bottles ] bi
    "There'll be %s green %s hanging on the wall." sprintf ;

:: verse ( n -- lines )
    n first-line
    dup
    "And if one green bottle should accidentally fall,"
    n fourth-line
    4array ;

:: recite ( start take -- lines )
    take <iota>
    [| fallen |
        start fallen -  verse
    ]
    map
    { "" } join ;