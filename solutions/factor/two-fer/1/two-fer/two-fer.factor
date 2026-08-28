USING: formatting kernel locals ;
IN: two-fer

! There are no variadic functions in Factor, due to the nature of the stack.

:: 2-for-1 ( name -- str )
    name
    [ name "One for %s, one for me." sprintf ]
    [ "One for you, one for me." ]
    if ;