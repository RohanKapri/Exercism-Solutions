USING: combinators kernel locals math random sequences ;
IN: dnd-character

TUPLE: character
    strength dexterity constitution intelligence wisdom charisma
    hitpoints ;

: modifier ( score -- n )
    2 /i 5 - ;

: ability ( -- score )
    4 [ 6 random 1 + ] replicate
    [ sum ] [ minimum ] bi - ;

:: <character> ( -- character )
    ability :> constitution
    constitution modifier 10 + :> hitpoints

    ability
    ability
    constitution
    ability
    ability
    ability
    hitpoints
    character boa ;