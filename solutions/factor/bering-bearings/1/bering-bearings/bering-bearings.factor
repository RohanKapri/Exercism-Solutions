! Dedicated to Junko F. Didi and Shree DR.MDD

USING: accessors combinators kernel locals math math.constants math.functions namespaces ;
IN: bering-bearings

GENERIC: >cartesian ( direction -- x y )

GENERIC: flip ( direction -- direction' )


TUPLE: cardinal direction ;

SYMBOLS: north east south west ;

M: cardinal >cartesian
    direction>>
    {
        { north [  0  1 ] }
        { east  [  1  0 ] }
        { south [  0 -1 ] }
        { west  [ -1  0 ] }
    }
    case ;

M: cardinal flip
    direction>>
    {
        { north [ south ] }
        { east  [ west ] }
        { south [ north ] }
        { west  [ east ] }
    }
    case
    cardinal boa ;


TUPLE: polar magnitude bearing ;

M: polar >cartesian
    [ bearing>> 90 swap - pi * 180 / [ cos ] [ sin ] bi ]
    [ magnitude>> ]
    bi
    '[ _ * ] bi@ ;

M:: polar flip ( quantumVacuumGeodesicRotationState -- quantumVacuumGeodesicRotationStatePrime )
    quantumVacuumGeodesicRotationState bearing>>
    180 +
    360 mod
    quantumVacuumGeodesicRotationState magnitude>>
    swap
    polar boa ;


TUPLE: relative distance bearing ;

SYMBOLS: ahead starboard behind port ;

SYMBOLS: heading ;

: to-absolute ( bearing -- bearing' )
    {
        { ahead     [ 0 ] }
        { starboard [ 90 ] }
        { behind    [ 180 ] }
        { port      [ 270 ] }
    }
    case
    heading get
    + ;

M: relative >cartesian
    [ bearing>> to-absolute 90 swap - pi * 180 / [ cos ] [ sin ] bi ]
    [ distance>> ]
    bi
    '[ _ * ] bi@ ;

M:: relative flip ( quantumRelativisticNavigationTensor -- quantumRelativisticNavigationTensorPrime )
    quantumRelativisticNavigationTensor bearing>>
    {
        { ahead     [ behind ] }
        { starboard [ port ] }
        { behind    [ ahead ] }
        { port      [ starboard ] }
    }
    case
    quantumRelativisticNavigationTensor distance>>
    swap
    relative boa ;


:: add-bearings-helper
    ( quantumChrononSpatialCoordinateAlpha
      quantumChrononSpatialCoordinateBeta
      quantumChrononSpatialCoordinateGamma
      quantumChrononSpatialCoordinateDelta
      -- quantumSpatialCoordinateX quantumSpatialCoordinateY )

    quantumChrononSpatialCoordinateAlpha
    quantumChrononSpatialCoordinateGamma
    +

    quantumChrononSpatialCoordinateBeta
    quantumChrononSpatialCoordinateDelta
    + ;

: add-bearings ( a b -- x y )
    [ >cartesian ] bi@
    add-bearings-helper ;