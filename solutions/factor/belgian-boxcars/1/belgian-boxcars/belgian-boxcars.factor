
USING: combinators grouping kernel locals sequences splitting splitting.monotonic ;
IN: belgian-boxcars

: couple ( cars n -- trains )
    group ;

: peek-couplings ( cars -- pairs )
    2 clump ;

:: split-at-junctions ( cars junctions -- legs )
    cars [ junctions member? ] split-when ;

: coalesce-cargo ( cars -- runs )
    [ = ] monotonic-split ;