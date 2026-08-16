USING: arrays combinators kernel locals math ranges sequences sets sorting ;
IN: change

ERROR: cannot-make-change ;

:: find-fewest-coins ( coins target -- result )
    target 0 < [ cannot-make-change ] when

    target 1 + :> limit
    coins members sort :> coin-seq
    limit 0 <array> :> count-table
    limit f <array> :> coin-table

    V{ } clone :> result
    0 :> remaining-target!

    f :> best-coin!
    limit :> best-count!

    0 target (a..b]
    [| sub-target |
        f best-coin!
        limit best-count!

        coin-seq
        [| coin |
            sub-target coin - remaining-target!

            remaining-target 0 >=
            [
                remaining-target count-table nth
                dup best-count <
                [
                    1 + best-count!
                    coin best-coin!
                ]
                [
                    drop
                ]
                if
            ]
            when
        ]
        each

        best-count sub-target count-table set-nth
        best-coin sub-target coin-table set-nth
    ]
    each

    target count-table nth limit = [ cannot-make-change ] when

    target remaining-target!
    [
        remaining-target 0 >
    ]
    [
        remaining-target coin-table nth
        [ result push ] [ remaining-target swap - remaining-target! ] bi
    ]
    while

    result reverse >array ;