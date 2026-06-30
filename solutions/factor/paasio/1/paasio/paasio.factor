USING: accessors destructors io kernel locals math sequences ;
IN: paasio


TUPLE: metered-input < disposable stream bytes ops ;

TUPLE: metered-output < disposable stream bytes ops ;


INSTANCE: metered-input input-stream

INSTANCE: metered-output output-stream


: <metered-input> ( stream -- m )
    metered-input new-disposable
    swap >>stream
    0 >>bytes
    0 >>ops ;

: <metered-output> ( stream -- m )
    metered-output new-disposable
    swap >>stream
    0 >>bytes
    0 >>ops ;


M: metered-input dispose*
  stream>> dispose ;

M: metered-output dispose*
  stream>> dispose ;


M:: metered-input stream-read1 ( stream -- elt )
    stream stream>> stream-read1 :> elt
    stream
    elt [ [ 1 + ] change-bytes ] when
    [ 1 + ] change-ops drop
    elt ;

M:: metered-input stream-read-unsafe ( n buf stream -- count )
    n buf stream stream>> stream-read-unsafe :> count
    stream [ count + ] change-bytes
    [ 1 + ] change-ops drop
    count ;

M: metered-input stream-element-type ( stream -- type )
    stream>> stream-element-type ;

M:: metered-output stream-write1 ( elt stream -- )
    elt  stream stream>>  stream-write1
    stream [ 1 + ] change-bytes
    [ 1 + ] change-ops drop ;

M:: metered-output stream-write ( data stream -- )
    data  stream stream>>  stream-write
    stream [ data length + ] change-bytes
    [ 1 + ] change-ops drop ;

M: metered-output stream-flush ( stream -- )
    [ 1 + ] change-ops
    stream>> stream-flush ;