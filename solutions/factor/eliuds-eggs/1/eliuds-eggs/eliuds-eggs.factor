USING: bit-arrays kernel locals math typed ;
IN: eliuds-eggs

TYPED:: egg-count ( n: fixnum -- count )
    0 n
    [ dup zero? not ]
    [
        swap 1 + swap
        dup dup neg bitand -
    ]
    while drop ;