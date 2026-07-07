USING: arrays assocs combinators kernel locals math ranges sequences ;
IN: piecing-it-together

:: inconsistent ( value key assoc -- ? )
    key assoc at
    [
        value = not
    ]
    [
        f
    ]
    if* ;

:: jigsaw-data ( partial -- full )
    f :> result!

    2 100 [a..b]
    [| rows |
        2 100 [a..b]
        [| columns |
            rows columns * :> pieces!
            rows columns + 2 - 2 * :> border!
            rows 2 -  columns 2 -  * :> inside!
            columns rows /f :> aspectRatio!
            {
                { [ rows columns < ] [ "landscape" ] }
                { [ rows columns > ] [ "portrait" ] }
                [ "square" ]
            }
            cond :> format!

            {
                { [ rows "rows" partial inconsistent ] [ ] }
                { [ columns "columns" partial inconsistent ] [ ] }
                { [ pieces "pieces" partial inconsistent ] [ ] }
                { [ border "border" partial inconsistent ] [ ] }
                { [ inside "inside" partial inconsistent ] [ ] }
                { [ aspectRatio "aspectRatio" partial inconsistent ] [ ] }
                { [ format "format" partial inconsistent ] [ ] }
                [
                    result [ "Insufficient data" throw ] when

                    H{ } clone result!
                    rows "rows" result set-at
                    columns "columns" result set-at
                    pieces "pieces" result set-at
                    border "border" result set-at
                    inside "inside" result set-at
                    aspectRatio "aspectRatio" result set-at
                    format "format" result set-at
                ]
            }
            cond
        ]
        each
    ]
    each

    result [ "Contradictory data" throw ] unless

    result ;