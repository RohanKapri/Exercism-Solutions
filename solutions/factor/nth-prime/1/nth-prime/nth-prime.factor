USING: kernel math math.primes typed ;
IN: nth-prime

: search ( n candidate -- prime )
    dup prime?
    [
        swap 1 - dup 0 <=
        [
          drop
        ]
        [
            swap 1 + search
        ]
        if
    ]
    [
        1 + search
    ]
    if ;

TYPED:: nth-prime ( n: integer -- prime: integer )
    n 0 = [ "there is no zeroth prime" throw ] when
    n 2 search ;