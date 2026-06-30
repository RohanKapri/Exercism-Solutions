USING: combinators formatting kernel math math.functions sequences ;
IN: resistor-color-trio
! from Resistor Color
: colors ( -- seq )
    { "black" "brown" "red" "orange" "yellow" "green" "blue" "violet" "grey" "white" } ;
: color>code ( color -- n )
    colors index ;
! from Resistor Color Duo
: value ( colors -- n )
    [ first color>code 10 * ] [ second color>code ] bi + ;
CONSTANT: units { "ohms" "kiloohms" "megaohms" "gigaohms" }
: label ( colors -- str )
    [ value ] [ third color>code 1 + 3 /mod ] bi
    swapd

    {
        { 0 [ dup 10 divisor? [ 10 / ] [ 10.0 / ] if ] }
        { 2 [ 10 * ] }
        [ drop ]
    }
    case

    swap units nth "%s %s" sprintf ;