USING: combinators kernel locals math math.bitwise math.parser multiline ranges sequences syntax ;
IN: state-of-tic-tac-toe

CONSTANT: lines { 0x007 0x070 0x700 0x111 0x222 0x444 0x124 0x421 }

:: win? ( bitset -- ? )
    lines [| line |
        bitset line bitand line =
    ] any? ;

:: gamestate ( board -- state )
    0 :> countX!
    0 :> countO!
    0 :> bitsetX!
    0 :> bitsetO!
    1 :> current!

    3 [0..b) [| i |
        3 [0..b) [| j |
            j i board nth nth {
                { CHAR: X [
                    countX 1 + countX!
                    bitsetX  4 i * j +  set-bit bitsetX!
                ] }
                { CHAR: O [
                    countO 1 + countO!
                    bitsetO  4 i * j +  set-bit bitsetO!
                ] }
                [ drop ]
            } case
        ] each
    ] each

    bitsetX win? :> winX
    bitsetO win? :> winO

    countX countO 1 + >
    [ "Wrong turn order: X went twice" throw ] when

    countO countX >
    [ "Wrong turn order: O started" throw ] when

    winX winO and
    countX countO 1 + = winO and
    countO countX = winX and
    or or
    [ "Impossible board: game should have ended after the game was won" throw ] when

    {
        { [ winX ] [ "win" ] }
        { [ winO ] [ "win" ] }
        { [ countX countO + 9 = ] [ "draw" ] }
        [ "ongoing" ]
    } cond ;