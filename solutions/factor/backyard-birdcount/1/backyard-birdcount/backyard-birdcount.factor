USING: kernel math sequences math.statistics ;
IN: backyard-birdcount

: today ( days -- count/f )
    [ f ] [ first ] if-empty ;

: increment-day-count ( days -- new-days )
    [ { 1 } ] [ clone dup 0 swap [ 1 + ] change-nth ] if-empty ;

: has-day-without-birds? ( days -- ? )
    [ 0 = ] find drop [ t ] [ f ] if ;

: total ( days -- sum )
    sum ;

: busy-days ( days -- count )
    [ 5 >= ] filter length ;