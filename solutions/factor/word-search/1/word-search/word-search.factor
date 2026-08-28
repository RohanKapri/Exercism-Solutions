USING: arrays assocs kernel locals math ranges sequences ;
IN: word-search

:: search-word ( grid word -- result )
    f :> result!
    word length 1 - :> last-word-index
    grid length :> num-rows
    grid empty? [ 0 ] [ grid first length ] if :> num-columns

    last-word-index num-rows < [ { -1 0 1 } ] [ { 0 } ] if
    [| di |
        0  di -1 = [ last-word-index + ] when
        num-rows  di 1 = [ last-word-index - ] when
        [a..b)
        [| i |
            last-word-index num-columns < [ { -1 0 1 } ] [ { 0 } ] if
            [| dj |
                0  dj -1 = [ last-word-index + ] when
                num-columns  dj 1 = [ last-word-index - ] when
                [a..b)
                [| j |
                    word length <iota>
                    [| k |
                        k word nth

                        k dj * j +
                        k di * i + grid nth
                        nth

                        =
                    ]
                    all?

                    [
                        j 1 +  i 1 +
                        2array
                        last-word-index dj * j + 1 +  last-word-index di * i + 1 +
                        2array
                        2array result!
                    ]
                    when

                ]
                each
            ]
            each
        ]
        each
    ]
    each

    result ;


:: search ( grid words -- results )
    words [| word | word  grid word search-word ] H{ } map>assoc ;