USING: ascii kernel locals sequences splitting ;
IN: log-levels

:: message ( log-line -- message )
    log-line ":" split1 swap drop
    [ blank? ] trim ;

:: log-level ( log-line -- level )
    log-line "]" split1 drop
    "[" split1 swap drop
    >lower ;

:: reformat ( log-line -- formatted )
    log-line message
    log-line log-level
    "(" ")" surround
    " " glue ;