USING: kernel locals math sequences ;
IN: backyard-birdwatcher

:: today ( days -- count )
    days last ;

:: increment-todays-count ( days -- new-days )
    days unclip-last 1 + suffix ;

:: has-day-without-birds? ( days -- ? )
    days [ zero? ] any? ;

:: count-for-first-days ( days n -- count )
    days n head sum ;

:: busy-days ( days -- count )
    days [ 5 >= ] count ;

:: pad-missing-days ( days n -- new-days )
    days n 0 pad-tail ;