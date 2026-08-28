USING: arrays combinators disjoint-sets kernel locals math math.functions sequences ;
IN: dominoes

:: can-chain? ( dominoes -- ? )
    16 0 <array> :> tally
    <disjoint-set> :> collection
    16 <iota> collection add-atoms

    f :> left!
    f :> right!
    0 :> representatives!

    dominoes
    [| stone |
        stone -4 shift left!
        stone 15 bitand right!

        left tally [ 1 + ] change-nth
        right tally [ 1 + ] change-nth
        left right collection equate
    ]
    each

    16 <iota>
    [| index |
        index tally nth
        {
            { [ dup 0 = ] [ drop ] }
            { [ odd? ] [ 17 representatives! ] }
            [
                index collection representative  index =
                [
                    representatives 1 + representatives!
                ]
                when
            ]
        }
        cond
    ]
    each

    representatives 1 <= ;