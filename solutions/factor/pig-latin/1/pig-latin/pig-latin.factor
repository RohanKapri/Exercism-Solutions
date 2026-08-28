USING: arrays combinators kernel locals math sequences splitting strings unicode ;
IN: pig-latin

CONSTANT: vowels { t f f f t f f f t f f f f f t f f f f f t f f f t f }

:: translate-word ( word -- result )
    word length :> word-len
    0 :> index!

    index word nth  CHAR: a  - vowels nth
    [
        0 word nth  CHAR: y  =
        [
            word "yt" ?head-slice nip  ! starts with yt
        ]
        [
            t  ! starts with a e i o u
        ]
        if
    ]
    [
        word "xr" ?head-slice nip  ! starts with xr
    ]
    if

    [
        index 1 + index!

        [
            index word-len <
            [
                index word nth  CHAR: a  - vowels nth not
            ]
            [
                f
            ]
            if
        ]
        [
            index 1 + index!
        ]
        while

        word  index 1 -  tail-slice "qu" ?head-slice nip
        [
            index 1 + index!
        ]
        when
    ]
    unless

    word index cut swap "ay" 3array concat ;

:: translate ( phrase -- result )
    phrase split-words harvest
    [
        translate-word
    ]
    map
    join-words ;