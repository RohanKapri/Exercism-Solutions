USING: kernel sequences ;
IN: list-ops

: list-append ( seq1 seq2 -- seq )
    append ;

: list-concat ( seqs -- seq )
    concat ;

: select ( seq quot -- seq' )
    filter ; inline

: collect ( seq quot -- seq' )
    map ; inline

: foldl ( seq init quot -- result )
    reduce ; inline

: foldr ( seq init quot -- result )
    rot reverse -rot reduce ; inline

: list-length ( seq -- n )
    length ;

: list-reverse ( seq -- seq' )
    reverse ;