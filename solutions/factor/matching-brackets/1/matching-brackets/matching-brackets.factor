USING: combinators continuations kernel locals math sequences ;
IN: matching-brackets

ERROR: unbalanced ;

:: unsuffix ( pending popping -- pending' )
    pending length 0 > [ unbalanced ] unless
    pending last popping = [ unbalanced ] unless
    pending but-last ;

:: paired? ( str -- ? )
    { } :> pending!

    [
        str
        [
            {
                {  91 [ pending  93 suffix pending! ] }     ! [ ]
                { 123 [ pending 125 suffix pending! ] }     ! { }
                {  40 [ pending  41 suffix pending! ] }     ! ( )

                {  93 [ pending  93 unsuffix pending! ] }   ! ]
                { 125 [ pending 125 unsuffix pending! ] }   ! }
                {  41 [ pending  41 unsuffix pending! ] }   ! )

                [ drop ]
            } case
        ]
        each

        pending length 0 = [ unbalanced ] unless

        t
    ]
    [
        drop f
    ]
    recover ;