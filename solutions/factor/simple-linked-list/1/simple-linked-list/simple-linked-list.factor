USING: accessors arrays kernel locals math sequences ;
IN: simple-linked-list

ERROR: list-empty ;

TUPLE: linked-list-node value next ;

TUPLE: linked-list head ;


! Then add
! `M: linked-list length` and `M: linked-list nth-unsafe` so the
! tests can call `length` and `>array` on your list.

: <linked-list> ( -- linked-list )
    f linked-list boa ;

:: list-push ( linked-list value -- linked-list )
    value  linked-list head>>  linked-list-node boa
    linked-list swap >>head ;

:: list-pop ( linked-list -- linked-list value )
    linked-list head>> [ list-empty ] unless
    linked-list head>> value>> :> value
    linked-list head>> next>> linked-list swap >>head
    value ;

:: list-peek ( linked-list -- value )
    linked-list head>> [ list-empty ] unless
    linked-list head>> value>> ;

:: >linked-list ( seq -- linked-list )
    <linked-list> :> result

    seq
    [| value |
        result value list-push drop
    ]
    each

    result ;

:: list-reverse ( linked-list -- linked-list )
    <linked-list> :> result

    linked-list head>> :> current!

    [ current ]
    [
        result current value>>  list-push drop
        current next>> current!
    ]
    while

    result ;

:: linked-list>array ( linked-list -- array )
    V{ } clone :> result
    linked-list head>> :> current!

    [ current ]
    [
        current value>> result push
        current next>> current!
    ]
    while

    result >array ;

:: linked-list-length ( head -- n )
    0 :> result!
    head :> current!

    [ current ]
    [
        result 1 + result!
        current next>> current!
    ]
    while

    result ;

! not implemented
:: linked-list-nth-unsafe ( head -- value )
    f ;

M: linked-list length head>> linked-list-length ;

!  M: linked-list nth-unsafe head>> linked-list-nth-unsafe ;