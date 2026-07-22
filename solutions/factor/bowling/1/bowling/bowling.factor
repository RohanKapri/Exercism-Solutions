USING: accessors arrays combinators kernel locals math ranges sequences vectors ;
IN: bowling

TUPLE: game frames ;

:: <game> ( -- game )
    V{ } clone :> frames
    frames game boa ;

:: gameOver? ( frames -- ? )
    {
        { [ frames length 10 < ]
          [ f ] }
        { [ 9 frames nth sum 10 < ]
          [ 9 frames nth length 2 = ] }
        { [ frames length 10 = ]
          [ f ] }
        { [ 9 frames nth length 2 = ]
          [ t ] }
        [ frames 10 tail-slice [ length ] map-sum 2 = ]
    } cond ;

:: roll ( pins game -- )
    game frames>> :> frames
    frames length :> frameCount

    frames gameOver? [ "Cannot roll after game is over" throw ] when

    pins 0 < [ "Negative roll is invalid" throw ] when

    {
        { [ frameCount 0 = ]
          [ pins 1array >vector frames push ] }
        { [ frames last [ length 2 = ] [ sum 10 = ] bi or ]
          [ pins 1array >vector frames push ] }
        [ pins frames last push ]
    }
    cond

    frames last sum 10 > [ "Pin count exceeds pins on the lane" throw ] when ;

:: frameScore ( index frames -- n )
    index frames nth sum :> result!

    ! spare
    result 10 = [
        index 1 + frames nth first result + result!
    ] when

    ! strike
    index frames nth first 10 = [
        index 1 + frames nth length 1 =
        [ index 2 + frames nth first ]
        [ index 1 + frames nth second ]
        if
        result + result!
    ] when

    result ;

:: score ( game -- n )
    game frames>> :> frames

    frames gameOver? [ "Score cannot be taken until the end of the game" throw ] unless

    10 [0..b) [| index | index frames frameScore ] map-sum ;