USING: kernel math math.bitwise ;
IN: secrets

:: shift-back ( value amount -- result )
    value 32 bits
    amount neg
    shift ;

:: set-bits ( value mask -- result )
    value mask bitor ;

:: flip-bits ( value mask -- result )
    value mask bitxor ;

:: clear-bits ( value mask -- result )
    value
    mask bitnot
    bitand ;