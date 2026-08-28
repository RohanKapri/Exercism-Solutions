USING: kernel math ;
IN: joiners-journey

: with-kerf ( length -- length+kerf )
    102 * 100 / ;

: kerf-and-finish ( length -- kerf finish )
    [ 2 * 100 / ] [ 5 * 100 / ] bi ;

: cut-card ( length -- length kerf finish )
    [ ] [ kerf-and-finish ] bi ;

: per-piece ( bolt-length pieces -- per-piece )
    [ with-kerf ] dip / ;

: compare-bolts ( length-a length-b -- kerf-a kerf-b )
    [ kerf-and-finish drop ] bi@ ;