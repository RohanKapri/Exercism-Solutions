USING: accessors arrays kernel locals math sequences sets ;
IN: custom-set

TUPLE: custom-set n ;

INSTANCE: custom-set set


: <custom-set> ( -- set )
    0 custom-set boa ;


:: >custom-set ( seq -- set )
    <custom-set> :> result
    seq
    [| elt |
        elt result adjoin
    ]
    each
    result ;


M:: custom-set members ( set -- seq )
    V{ } clone :> result
    set n>> :> m!
    0 :> index!
    [
        m 0 =
    ]
    [
        m 1 bitand 0 >
        [
            index result push
        ]
        when

        m -1 shift m!
        index 1 + index!
    ]
    until
    result >array ;


M:: custom-set in? ( elt set -- ? )
    1 elt shift  set n>>  bitand 0 > ;


M:: custom-set adjoin ( elt set -- )
    1 elt shift  set n>>  bitor set swap >>n drop ;


M:: custom-set set-like ( set exemplar -- set' )
    set members >custom-set ;