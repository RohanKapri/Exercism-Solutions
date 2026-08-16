USING: kernel locals math sequences strings ;
IN: micro-blog

:: truncate ( str -- str' )
    str length 5 >
    [ str 5 head >string ]
    [ str ]
    if ;