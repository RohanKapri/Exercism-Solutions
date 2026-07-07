USING: arrays combinators kernel locals math math.statistics sequences strings ;
IN: rail-fence-cipher


:: process ( msg rails encoding? -- msg' )
    msg length 32 <array> :> result
    rails 1 + 0 <array> :> tally

    0 :> rail!
    1 :> direction!

    msg length
    [
        rail 1 +  tally [ 1 + ] change-nth
        rail direction + rail!
        rail 0 =  rail 1 + rails =  or [ direction neg direction! ] when
    ]
    times

    tally cum-sum >array :> offsets

    0 rail!
    1 direction!

    msg length
    [| offset |
        encoding?
        [
            offset msg nth
            rail offsets nth
            result
            set-nth
        ]
        [
            rail offsets nth  msg nth
            offset
            result
            set-nth
        ]
        if

        rail offsets [ 1 + ] change-nth


        rail direction + rail!
        rail 0 =  rail 1 + rails =  or [ direction neg direction! ] when
    ]
    each-integer

    result >string ;


: encode ( msg rails -- cipher )
    t process ;


: decode ( msg rails -- plain )
    f process ;