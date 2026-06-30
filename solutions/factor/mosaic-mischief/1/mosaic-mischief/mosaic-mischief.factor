USING: arrays kernel locals sequences ;
IN: mosaic-mischief

: fresh-mosaic ( n -- row )
    f <array> ;

:: place-tile ( row position colour -- )
    colour position row set-nth ;

:: chip-tile ( row position -- )
    f position row set-nth ;

:: recolour-tile ( row position quot -- )
    position row quot change-nth ; inline

: snapshot-mosaic ( row -- copy )
    clone ;

: stash-tile ( hoard tile -- )
    swap push ;

: return-tile ( hoard -- tile )
    pop ;