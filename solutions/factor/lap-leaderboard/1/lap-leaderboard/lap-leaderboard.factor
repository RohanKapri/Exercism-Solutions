USING: arrays kernel math math.parser sequences strings ;
IN: lap-leaderboard

: assign-bibs ( names -- pairs )
    [ swap 2array ] map-index ;

: lane-labels ( names -- labels )
    [ number>string "Lane " prepend swap ": " prepend append ] map-index ;

: tag-racers ( names tag -- tagged )
    '[ number>string _ "/" append prepend swap ": " prepend append ] map-index ;

: record-finishes ( names ledger -- )
    '[ number>string ": " append swap append _ push ] each-index ;

: lap-bells ( laps -- str )
    '[ "" _ [ "ding " append ] times ] call ;