USING: accessors combinators kernel math namespaces sequences ;
IN: garden-gathering

TUPLE: plot id registered-to ;

SYMBOLS: registrations next-id not-found ;

: open-garden ( -- )
    V{ } clone registrations set-global
    1 next-id set-global ;

: list-registrations ( -- plots )
    registrations get-global ;

: register ( name -- plot )
    next-id get-global swap plot boa ! new-plot
    registrations over '[ _ suffix ] change-global
    next-id [ 1 + ] change-global ;

: release ( id -- )
    registrations swap '[ [ id>> _ = ] reject ] change-global ;

: get-registration ( id -- plot/symbol )
    registrations get-global swap ! vec id
    '[ id>> _ = ] find ! index elt/f
    nip
    [ not-found ] unless* ;

: find-by-name ( name -- plots )
    registrations get-global swap ! vec name
    '[ registered-to>> _ = ] filter ;