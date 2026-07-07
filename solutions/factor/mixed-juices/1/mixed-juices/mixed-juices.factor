USING: combinators kernel math sequences ;
IN: mixed-juices

: time-to-mix-juice ( juice -- minutes )
   {
       { "Pure Strawberry Joy" [ 0.5 ] }
       { "Energizer" [ 1.5 ] }
       { "Green Garden" [ 1.5 ] }
       { "Tropical Island" [ 3 ] }
       { "All or Nothing" [ 5 ] }
       [ drop 2.5 ]
   } case ;

: wedges-from-lime ( size -- wedges )
    { "small" "medium" "large" } index 3 + 2 * ;

:: limes-to-cut ( needed limes -- count )
    0 0 :> ( i! wedges! )
    [ wedges needed >= i limes length = or ] [
        i limes nth wedges-from-lime wedges + wedges!
        i 1 + i!
    ] until i ;

: order-times ( orders -- times )
    [ time-to-mix-juice ] map ;

: remaining-orders ( time-left orders -- remaining )
    [ time-to-mix-juice - dup 0 <= ] filter nip
    dup length 1 > [ rest ] when ;