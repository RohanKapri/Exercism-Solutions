USING: kernel locals math typed ;
IN: collatz-conjecture

TYPED:: steps ( n: fixnum -- steps )
    n 0 > [ "Only positive integers are allowed" throw ] unless
    0 n
    [ dup 1 > ]
    [
        swap 1 + swap
        dup odd?
        [ 3 * 1 + ]
        [ 2 / ]
        if
    ]
    while drop ;