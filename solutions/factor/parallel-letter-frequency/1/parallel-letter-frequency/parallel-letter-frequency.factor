USING: assocs combinators kernel concurrency.combinators concurrency.promises hashtables locals math sequences threads unicode ;
IN: parallel-letter-frequency

:: measure-frequencies ( text -- counts )
    26 <hashtable> :> result!

    text
    [| ch |
        ch Letter?
        [
            1  ch ch>lower  result at+
        ]
        when
    ]
    each

    result ;

:: calculate-frequencies ( texts -- counts )
    26 <hashtable> :> result!

    texts
    [| text |
        <promise>
        [
            '[
                text measure-frequencies
                _ fulfill
            ]
            "answer" spawn drop
        ]
        keep
    ]
    map
    [
        ?promise
        [| key value |
            value
            key result at+
        ]
        assoc-each
    ]
    each

    result ;