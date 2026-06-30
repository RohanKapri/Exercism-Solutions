USING: assocs combinators kernel locals math sequences ;
IN: lasagna-luminary

:: cooking-status ( timer -- string )
    {
        { [ timer 0 = ] [ "Lasagna is done." ] }
        { [ timer f = ] [ "You forgot to set the timer." ] }
        [ "Not done, please wait." ]
    }
    cond ;

:: preparation-time ( layers minutes-per-layer -- total )
    layers length minutes-per-layer * ;

:: quantities ( layers -- noodles sauce )
    layers [ "noodles" = ] filter length 50 *
    layers [ "sauce" = ] filter length 5 / ;

:: add-secret-ingredient ( friends-list my-list -- new-list )
    my-list
    friends-list last
    suffix ;

:: scale-recipe ( recipe portions -- new-recipe )
    recipe [| key value | key value portions * 2 / ] assoc-map ;