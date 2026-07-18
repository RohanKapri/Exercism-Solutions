USING: arrays kernel locals math sequences ;
IN: secret-handshake

:: commands ( number -- actions )
    V{ } clone :> result
    number 1 bitand 0 > [ "wink" result push ] when
    number 2 bitand 0 > [ "double blink" result push ] when
    number 4 bitand 0 > [ "close your eyes" result push ] when
    number 8 bitand 0 > [ "jump" result push ] when

    result
    number 16 bitand 0 > [ reverse! ] when
    >array ;