USING: combinators kernel locals sequences strings unicode ;
IN: bob

:: response-impl ( str -- answer )
    str empty?
    [
        "Fine. Be that way!"
    ]
    [
        str >upper str =
        str >lower str = not
        and
        [
            str last 63 =
            [
                "Calm down, I know what I'm doing!"
            ]
            [
                "Whoa, chill out!"
            ]
            if
        ]
        [
            str last 63 =
            [
                "Sure."
            ]
            [
                "Whatever."
            ]
            if
        ]
        if
    ]
    if ;

: response ( str -- answer )
    [ blank? ] trim
    response-impl ;