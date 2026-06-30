USING: assocs kernel locals math.order sequences splitting unicode ;
IN: word-count

:: count-words ( sentence -- counts )
    H{ } clone :> result

    sentence >lower
    [
        [ 39 = ] [ digit? ] [ alpha? ] tri or or not
    ]
    split-when
    [
        [ 39 = ] trim
    ]
    map
    harvest
    [
        result inc-at
    ]
    each

    result ;