USING: accessors arrays classes kernel locals math.order sequences ;
IN: binary-search-tree

TUPLE: bst ;
TUPLE: leaf < bst ;
TUPLE: branch < bst data left right ;

: branch-left ( branch -- left )
    left>> ;

: branch-right ( branch -- right )
    right>> ;

: branch-data ( branch -- data )
    data>> ;

:: insert-value ( value tree -- )
    value  tree branch-data  before=?
    [
        tree branch-left leaf instance?
        [
            tree

            value
            leaf boa
            leaf boa
            branch boa

            >>left drop
        ]
        [
            value
            tree left>>
            insert-value
        ]
        if
    ]
    [
        tree branch-right leaf instance?
        [
            tree

            value
            leaf boa
            leaf boa
            branch boa

            >>right drop
        ]
        [
            value
            tree right>>
            insert-value
        ]
        if
    ]
    if ;

:: <bst> ( data-seq -- tree )
    data-seq empty?
    [
        leaf boa
    ]
    [
        data-seq first
        leaf boa
        leaf boa
        branch boa :> result

        data-seq rest
        [| value |
            value result insert-value
        ]
        each

        result
    ] if ;

GENERIC: sorted-data ( tree -- seq )

M: leaf sorted-data
    drop { } ;

M: branch sorted-data
    [ branch-left sorted-data ]
    [ branch-data 1array ]
    [ branch-right sorted-data ]
    tri 3array concat ;