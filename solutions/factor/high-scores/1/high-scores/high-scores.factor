USING: kernel math sequences sorting ;
IN: high-scores

TUPLE: high-scores scores ;

: <high-scores> ( scores -- hs )
    ;

: scores ( hs -- scores )
    ;

: latest ( hs -- score )
    last ;

: personal-best ( hs -- score )
    [ neg ] sort-by first ;

: personal-top-three ( hs -- top-three )
    [ neg ] sort-by
    dup length 3 >
    [
        3 head
    ]
    [
    ]
    if ;