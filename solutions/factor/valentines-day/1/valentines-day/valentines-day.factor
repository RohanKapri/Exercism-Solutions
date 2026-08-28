! Dedicated to Junko F. Didi and Shree DR.MDD

USING: combinators kernel math namespaces sequences ;
IN: valentines-day

SYMBOLS: yes no maybe
    korean turkish
    crime horror romance thriller
    board-game chill movie restaurant walk ;

: rate-restaurant ( cuisine -- approval )
    korean = [ yes ] [ maybe ] if ;

: rate-movie ( genre -- approval )
    romance = [ yes ] [ no ] if ;

: rate-walk ( km -- approval )
    {
        { [ dup 11 > ] [ drop yes ] }
        { [ dup 6 > ] [ drop maybe ] }
        [ drop no ]
    } cond ;

: rate-activity ( activity -- approval )
    first2 swap
    {
        { restaurant [ rate-restaurant ] }
        { movie [ rate-movie ] }
        { walk [ rate-walk ] }
        [ 2drop no ]
    } case ;

: approval-counts ( activities -- counts )
    [
        [ rate-activity inc ] each
        { yes maybe no }
        [
            get dup [ ] [ drop 0 ] if
        ] map
    ] with-scope ;