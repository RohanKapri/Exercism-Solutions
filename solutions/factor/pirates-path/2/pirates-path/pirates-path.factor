USING: arrays assocs combinators continuations deques dlists hash-sets kernel locals math sequences sets ;
IN: pirates-path


:: tide-queue ( items -- popped )
    <dlist> :> deque
    V{ } clone :> result

    items
    [
        deque push-back
    ]
    each
    

    [
        deque deque-empty?
    ]
    [
        deque pop-front
        result push
    ]
    until

    result >array ;


:: coves-reachable ( start chart -- coves )
    <dlist> :> frontier
    HS{ } clone :> visited

    start [ frontier push-back ] [ visited adjoin ] bi

    [ frontier deque-empty? ]
    [
        frontier pop-front
        chart at
        [
            visited in?
        ]
        reject
        [
            [ frontier push-back ] [ visited adjoin ] bi
        ]
        each
    ]
    until

    visited ;


:: hop-count ( start goal chart -- n/f )
    <dlist> :> frontier
    HS{ } clone :> visited

    start :> cove!
    0 :> distance!
    f :> neighbour!

    f :> result!

    cove distance 2array [ frontier push-back ] [ visited adjoin ] bi

    [ frontier deque-empty? ]
    [
        frontier pop-front
        [ first cove! ] [ second distance! ] bi

        cove goal =
        [
            distance result!
        ]
        when

        cove
        chart at
        [
            visited in?
        ]
        reject
        [| neighbour |
            neighbour visited adjoin
            neighbour  distance 1 +  2array frontier push-back
        ]
        each
    ]
    until

    result ;


CONSTANT: gold-distribution H{
    { "Hidden Cove"        80 }
    { "Skull Bay"         120 }
    { "Reef Point"         40 }
    { "Smuggler's Hollow" 200 }
    { "Plank Island"       60 }
    { "Lantern Rock"      150 }
}


MEMO: gold-count ( cove -- n )
    gold-distribution at
    [ 0 ] unless* ;


:: treasure-route ( start chart -- best-cove )
    f :> best-cove!
    0 :> best-gold!

    0 :> gold!

    start chart coves-reachable members
    [| cove |
        cove gold-count gold!
        best-gold gold <
        [
            cove best-cove!
            gold best-gold!
        ]
        when
    ]
    each

    best-cove ;