USING: accessors arrays assocs combinators continuations hash-sets hashtables kernel locals math ranges sequences sets sorting splitting unicode ;
IN: alphametics

TUPLE: letter-info ch leading rank weight digit ;


:: word-signs ( tokens -- words )
    V{ } clone :> result
    -1 :> sign!
    tokens
    [
        {
            { "==" [ 1 sign! ] }
            { "+" [ ] }
            [| token |
                token sign 2array result push
            ]
        }
        case
    ]
    each

    result >array ;


: unique-letters ( puzzle -- set )
    [ Letter? ] filter >hash-set ;


:: make-letter-info ( ch words -- letter-info )
    words [ first length ] map maximum :> cols
    cols 0 <array> :> weight
    0 :> leading!

    words
    [| word sign |
        word length :> len
        len 1 >  word first ch =  and [ 1 leading! ] when
        word reverse
        [| word-ch index |
            ch word-ch =
            [
                index weight [ sign + ] change-nth
            ]
            when
        ]
        each-index
    ]
    assoc-each

    f :> rank!
    weight
    [| w index |
        w 0 =  rank  or [ index rank! ] unless
    ]
    each-index

    rank  cols 1 -  or rank!

    ch leading rank weight f letter-info boa ;


:: column-sum ( col letter-infos -- n )
    0 :> result!

    letter-infos
    [| info |
        col  info weight>>  nth :> w
        w 0 = [ w  info digit>>  * result + result! ] unless
    ]
    each

    result ;

! depth-first search
:: search ( index claimed col carry letter-infos cols -- )
    letter-infos length index = :> column-complete!
    column-complete
    [
        index letter-infos nth rank>> col > column-complete!
    ]
    unless

    column-complete
    [
        col letter-infos column-sum  carry + :> column-sum

        {
            { [ column-sum 10 mod 0 = not ] [ ] }
            { [ col 1 +  cols < ] [ index claimed  col 1 +  column-sum 10 /i  letter-infos cols search ] }
            { [ column-sum 0 = not ] [ ] }
            [
                ! solution found
                letter-infos
                [| info |
                    info [ ch>> ] [ digit>> ] bi
                ]
                H{ } map>assoc
                throw
            ]
        }
        cond


    ]
    [
        index letter-infos nth leading>> 9
        [a..b]
        [| digit |
            1 digit shift :> bit
            bit claimed bitand 0 =
            [
                index letter-infos nth digit >>digit drop
                index 1 +  claimed bit bitor  col carry letter-infos cols search
            ]
            when
        ]
        each
    ]
    if ;


:: solve ( puzzle -- mapping/f )
    puzzle " " split harvest word-signs :> words
    words [ first length ] map maximum :> cols
    puzzle unique-letters :> letters

    letters members
    [| ch |
        ch words make-letter-info
    ]
    map
    [ rank>> ] sort-by >array :> letter-infos

    [ 0 0 0 0 letter-infos cols search f ] [ ] recover ;