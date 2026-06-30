USING: accessors arrays kernel locals math math.order ranges sequences ;
IN: knapsack

TUPLE: item weight value ;

:: maximum-value ( max-weight items -- value )
    max-weight 1 +  0 <array> :> table
    items
    [| item |
        ! For each weight `i`, `i table nth` contains the maximum value achievable
        ! with the items seen to date. Each item may only be used once.

        item weight>> max-weight <=
        [
            max-weight
            item weight>>
            [a..b] ! descending
            [| i |
                i table nth
                i item weight>> - table nth item value>> +
                max
                i table set-nth
            ]
            each
        ]
        when
    ]
    each

    max-weight table nth ;