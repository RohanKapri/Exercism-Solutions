USING: accessors deques dlists kernel locals math ;
IN: circular-buffer
TUPLE: circular-buffer capacity queue ;
:: <circular-buffer> ( capacity -- buffer )
    capacity <dlist> circular-buffer boa ;
:: write ( item buffer -- )
    buffer capacity>>
    buffer queue>> dlist-length
    = [ "buffer is full" throw ] when

    item  buffer queue>>  push-back ;
:: read ( buffer -- item )
    buffer queue>> deque-empty? [ "buffer is empty" throw ] when

    buffer queue>>  pop-front ;
:: overwrite ( item buffer -- )
    buffer capacity>>
    buffer queue>> dlist-length
    = [ buffer read drop ] when
    item buffer write ;
:: clear-buffer ( buffer -- )
    buffer queue>> clear-deque ;