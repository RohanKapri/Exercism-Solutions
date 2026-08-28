USING: kernel math ;
IN: grains

:: square ( n -- grains )
    n 1 >=
    n 64 <=
    and [ "square must be between 1 and 64" throw ] unless
    n 1 -
    1 swap shift ;

: total ( -- grains )
    1 64 shift
    1 - ;