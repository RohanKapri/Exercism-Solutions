USING: kernel sequences splitting strings unicode ;
IN: acronym

: abbreviate ( phrase -- acronym )
    >upper [ 39 = not ] filter ! filter out the '
    [ dup Letter? [ ] [ drop 32 ] if ] map ! convert anything not a letter to a space
    " " split harvest ! sequence of non-empty words
    [ first 1string ] map concat ;