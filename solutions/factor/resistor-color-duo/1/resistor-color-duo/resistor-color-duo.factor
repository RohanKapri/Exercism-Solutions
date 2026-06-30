USING: combinators kernel math sequences ;
IN: resistor-color-duo

: colors ( -- seq )
    { "black" "brown" "red" "orange" "yellow" "green" "blue" "violet" "grey" "white" } ;

: color>code ( color -- n )
    colors index ;

: value ( colors -- n )
    [ first color>code 10 * ] [ second color>code ] bi + ;