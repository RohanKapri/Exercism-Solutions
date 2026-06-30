USING: hash-sets kernel locals math namespaces sets sequences ;
IN: satellite

TUPLE: tree value left right ;

ERROR: invalid-traversals ;

SYMBOLS: preorder-seq inorder-seq preorder-index inorder-index ;


:: build ( successor -- tree )
    preorder-seq get length  preorder-index get  =
    [
        f
    ]
    [
        inorder-index get  inorder-seq get  ?nth  successor =
        [
            f
        ]
        [
            preorder-index get  preorder-seq get  nth :> value
            preorder-index [ 1 + ] change
            value build :> left

            inorder-index get  inorder-seq get  ?nth value =
            [
                invalid-traversals
            ]
            unless

            inorder-index [ 1 + ] change
            successor build :> right

            value left right tree boa
        ]
        if
    ]
    if ;


:: tree-from-traversals ( preorder inorder -- tree )
    preorder length  inorder length  =
    preorder length  preorder >hash-set cardinality  =
    inorder length  inorder >hash-set cardinality  =
    and and
    [
        invalid-traversals
    ]
    unless

    preorder preorder-seq
    [
        inorder inorder-seq
        [
            0 preorder-index
            [
                0 inorder-index
                [
                    f build
                ]
                with-variable
            ]
            with-variable
        ]
        with-variable
    ]
    with-variable ;