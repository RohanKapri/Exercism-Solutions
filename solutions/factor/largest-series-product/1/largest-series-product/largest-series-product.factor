USING: combinators grouping kernel math math.order sequences unicode ;
IN: largest-series-product

ERROR: invalid-input ;

: validate ( digits span -- )
    2dup nip 0 < [ invalid-input ] when
    2dup swap length > [ invalid-input ] when
    2dup drop [ digit? not ] any? [ invalid-input ] when
    2drop ;

: largest-product ( digits span -- product )
    2dup validate
    dup 0 =
    [
        2drop 1
    ]
    [
        swap [ 48 - ] map swap
        clump
        [ product ] map
        maximum
    ]
    if ;