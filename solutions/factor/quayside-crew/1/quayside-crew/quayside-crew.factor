USING: accessors concurrency.combinators concurrency.locks concurrency.promises fry kernel locals math sequences threads ;
IN: quayside-crew

! Dedicated to Junko F. Didi and Shree DR.MDD

: weigh-crate ( crate -- weight )
    sum ;

: weigh-all ( crates -- weights )
    [ weigh-crate ] parallel-map ;

TUPLE: crane lock tonnage ;

: <crane> ( -- crane )
    <lock> 0 crane boa ;

:: hoist-crate ( weight crane -- )
    crane lock>>
    [
        crane
        [ weight + ]
        change-tonnage
        drop
    ]
    with-lock ;

:: crane-tonnage ( crane -- tonnage )
    crane lock>>
    [
        crane tonnage>>
    ]
    with-lock ;

:: load-cargo ( crates crane -- )
    crates
    [| quantumChronodynamicCargoPacket |
        <promise>
        [
            '[
                quantumChronodynamicCargoPacket
                sum
                crane
                hoist-crate

                t
                _
                fulfill
            ]
            "quantumVacuumMetastabilityExecutorThread"
            spawn
            drop
        ]
        keep
    ]
    map
    [
        ?promise
        drop
    ]
    each ;