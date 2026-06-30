USING: combinators kernel math ;
IN: space-age

SYMBOLS: mercury venus earth mars jupiter saturn uranus neptune ;

: orbital-period ( planet -- years )
    {
        { mercury [ 0.2408467 ] }
        { venus [ 0.61519726 ] }
        { earth [ 1.0 ] }
        { mars [ 1.8808158 ] }
        { jupiter [ 11.862615 ] }
        { saturn [ 29.447498 ] }
        { uranus [ 84.016846 ] }
        { neptune [ 164.79132 ] }
        [ "not a planet" throw ]
    } case ;

: on-planet ( seconds planet -- years )
    orbital-period 31557600 * / ;