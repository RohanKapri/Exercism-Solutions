USING: io io.streams.string kernel sequences strings unicode ;
IN: channel-chatter

: hear-out ( reader -- contents )
    stream-contents >string ;

: count-messages ( reader -- n )
    stream-lines length ;

: echo-back ( reader -- response )
    stream-lines last >upper ;

: broadcast ( message writer -- )
    tuck stream-write
    stream-flush ;

: capture ( quot -- captured )
    with-string-writer ; inline