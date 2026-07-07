USING: kernel sequences ;
IN: resistor-color

: colors ( -- seq )
    { "black" "brown" "red" "orange" "yellow" "green" "blue" "violet" "grey" "white" } ;

: color>code ( color -- n )
    colors index ;