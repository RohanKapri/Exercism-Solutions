USING: ascii kernel sequences splitting strings ;
IN: high-school-sweetheart

:: cleanupname ( name -- cleaned )
    name "-" " " replace
    [ blank? ] trim ;

:: firstletter ( name -- letter )
    name cleanupname
    first 1string ;

:: initial ( name -- initial )
    name firstletter
    >upper
    "." append ;

:: couple ( name1 name2 -- formatted )
    "❤ "
    name1 initial append
    "  +  " append
    name2 initial append
    " ❤" append ;