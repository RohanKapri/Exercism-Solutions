USING: kernel locals math typed ;
IN: square-root

TYPED:: square-root-search ( guess n: fixnum -- root )
    guess dup * n =
    [ guess ]
    [ guess 1 + guess * n + guess 2 * /i n square-root-search ]
    if ;

TYPED:: square-root ( n: fixnum -- root )
    1 n square-root-search ;