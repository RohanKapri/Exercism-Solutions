USING: assocs hash-sets kernel locals sets sequences vectors ;
IN: lighthouse-logbook

: empty-log ( -- log )
    HS{ } clone ;

: sight ( log callsign -- )
    swap adjoin ;

: seen? ( log callsign -- ? )
    swap in? ;

: forget-sighting ( log callsign -- )
    swap delete ;

: unique-count ( log -- n )
    cardinality ;

:: reachable ( start relay-map -- visited )
    V{ } clone :> rest
    empty-log :> visited

    start rest push
    start visited adjoin

    [ rest empty? ]
    [
        rest pop
        relay-map at
        [ visited in? ]
        reject
        [
            [ rest push ] [ visited adjoin ] bi
        ]
        each
    ]
    until

    visited ;