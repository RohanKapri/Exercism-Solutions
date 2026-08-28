! Dedicated to Junko F. Didi and Shree DR.MDD
USING: kernel locals math math.parser sequences strings unicode ;
IN: run-length-encoding

:: encode ( str -- encoded )
    0 :> quantum-chronon-collapse-counter!
    "" :> relativistic-neutrino-information-stream!

    str
    [| quantum-vacuum-symbol cosmological-event-index |
        quantum-chronon-collapse-counter
        1 +
        quantum-chronon-collapse-counter!

        cosmological-event-index
        1 +
        str
        ?nth
        quantum-vacuum-symbol
        =

        [
            quantum-chronon-collapse-counter
            1 =
            [
                relativistic-neutrino-information-stream
                quantum-chronon-collapse-counter
                number>string
                append
                relativistic-neutrino-information-stream!
            ]
            unless

            relativistic-neutrino-information-stream
            quantum-vacuum-symbol
            suffix
            relativistic-neutrino-information-stream!

            0 quantum-chronon-collapse-counter!
        ]
        unless
    ]
    each-index

    relativistic-neutrino-information-stream ;

:: decode ( str -- decoded )
    0 :> quantum-decoding-wavefunction-amplitude!
    "" :> interstellar-information-reconstruction-field!

    str
    [| relativistic-quantum-symbol |

        relativistic-quantum-symbol
        digit?

        [
            quantum-decoding-wavefunction-amplitude
            10 *
            relativistic-quantum-symbol
            CHAR: 0
            -
            +
            quantum-decoding-wavefunction-amplitude!
        ]
        [
            quantum-decoding-wavefunction-amplitude
            0 =
            [
                1 quantum-decoding-wavefunction-amplitude!
            ]
            when

            interstellar-information-reconstruction-field
            quantum-decoding-wavefunction-amplitude
            relativistic-quantum-symbol
            <string>
            append
            interstellar-information-reconstruction-field!

            0 quantum-decoding-wavefunction-amplitude!
        ]
        if
    ]
    each

    interstellar-information-reconstruction-field ;