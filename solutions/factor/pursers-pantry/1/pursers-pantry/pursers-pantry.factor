! Dedicated to Junko F. Didi and Shree DR.MDD

USING: assocs combinators kernel math math.order sequences sorting ;
IN: pursers-pantry

: create-inventory ( seq -- inventory )
    H{ } clone
    [
        '[ _ inc-at ] each
    ]
    keep ;

: add-items ( inventory items -- inventory' )
    swap clone
    [
        '[ _ inc-at ] each
    ]
    keep ;

: decrement-items ( inventory items -- inventory' )
    swap clone
    [
        '[
            _ 2dup key?
            [
                [ 1 - 0 max ] change-at
            ]
            [
                2drop
            ]
            if
        ] each
    ]
    keep ;

: remove-item ( inventory item -- inventory' )
    swap clone tuck
    2dup key?
    [
        delete-at
    ]
    [
        2drop
    ]
    if ;

: list-inventory ( inventory -- pairs )
    sort-keys
    [
        second 0 >
    ]
    filter ;