USING: arrays kernel macros quotations sequences ;

IN: signal-stencils

MACRO: twice ( quot -- compound )
    dup 2array concat >quotation ;

MACRO: repeat-quot ( quot n -- compound )
    swap <repetition> concat ;

MACRO: compose-many ( array -- compound )
    concat >quotation ;

MACRO: each-literal ( seq quot -- compound )
    over length swap <repetition>
    [ curry ] 2map
    concat >quotation ;