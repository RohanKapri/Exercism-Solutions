USING: combinators kernel locals math math.functions sequences strings ;
IN: ocr-numbers

CONSTANT: question 63

: convert-digit ( rows -- ch )
    {
        { { " _ " "| |" "|_|" "   " } [ CHAR: 0 ] }
        { { "   " "  |" "  |" "   " } [ CHAR: 1 ] }
        { { " _ " " _|" "|_ " "   " } [ CHAR: 2 ] }
        { { " _ " " _|" " _|" "   " } [ CHAR: 3 ] }
        { { "   " "|_|" "  |" "   " } [ CHAR: 4 ] }
        { { " _ " "|_ " " _|" "   " } [ CHAR: 5 ] }
        { { " _ " "|_ " "|_|" "   " } [ CHAR: 6 ] }
        { { " _ " "  |" "  |" "   " } [ CHAR: 7 ] }
        { { " _ " "|_|" "|_|" "   " } [ CHAR: 8 ] }
        { { " _ " "|_|" " _|" "   " } [ CHAR: 9 ] }
        [ drop question ]
    }
    case ;

:: convert-triplet ( rows -- str )
    rows first length 3 /i <iota>
    [| j |
        rows
        [
            3 j * tail-slice 3 head-slice >string
        ]
        map
        convert-digit
    ]
    map
    >string ;

:: convert ( rows -- str )
    {
        { [ rows length 4 divisor? not ] [ "Number of input lines is not a multiple of four" throw ] }
        { [ rows empty? ] [ "" ] }
        { [ rows first length 3 divisor? not ] [ "Number of input columns is not a multiple of three" throw ] }
        [
            rows length 4 /i <iota>
            [| i |
                rows 4 i * tail-slice 4 head-slice convert-triplet
            ]
            map
            "," join
        ]
    }
    cond ;