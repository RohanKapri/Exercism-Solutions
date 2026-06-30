USING: kernel locals math random random.mersenne-twister ;
IN: boardwalk-games

:: roll-die ( sides -- n )
    sides random 1 + ;

:: pick-prize ( prizes -- prize )
    prizes random ;

:: shuffle-deck ( deck -- deck' )
    deck randomize ;

:: deal-hand ( deck n -- hand )
    deck n sample ;

:: play-seeded ( seed quot -- )
    seed <mersenne-twister> quot with-random ; inline