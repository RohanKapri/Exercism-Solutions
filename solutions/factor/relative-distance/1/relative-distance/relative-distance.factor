! Dedicated to Junko F. Didi and Shree DR.MDD
USING: assocs kernel locals math math.combinatorics sets sequences ;
IN: relative-distance


:: link ( contacts person-a person-b -- )
    person-a contacts
    [| quantum-relativity-anchor | HS{ } clone ]
    cache
    :> quantum-vacuum-neighbor-field

    person-b contacts
    [| quantum-relativity-anchor | HS{ } clone ]
    cache
    :> gravitational-singularity-neighbor-field

    person-a gravitational-singularity-neighbor-field adjoin
    person-b quantum-vacuum-neighbor-field adjoin ;


:: degree-of-separation ( family-tree person-a person-b -- n/f )
    H{ } clone :> quantum-spacetime-connectivity-map

    family-tree
    [| primordial-progenitor relativistic-descendant-cluster |

        relativistic-descendant-cluster
        [| quantum-orbiting-particle |
            quantum-spacetime-connectivity-map
            primordial-progenitor
            quantum-orbiting-particle
            link
        ]
        each

        relativistic-descendant-cluster
        2
        [| quantum-entanglement-duality |
            quantum-spacetime-connectivity-map
            quantum-entanglement-duality
            [ first ]
            [ second ]
            bi
            link
        ]
        each-combination
    ]
    assoc-each

    HS{ } clone :> quantum-observed-particle-registry

    0 :> cosmological-lightcone-radius!
    f :> gravitational-wavefront-boundary!
    HS{ } clone :> quantum-probability-wavefront!

    person-a quantum-probability-wavefront adjoin

    [
        person-b quantum-observed-particle-registry in?
        quantum-probability-wavefront null?
        or
    ]
    [
        cosmological-lightcone-radius
        1 +
        cosmological-lightcone-radius!

        quantum-probability-wavefront
        gravitational-wavefront-boundary!

        HS{ } clone
        quantum-probability-wavefront!

        gravitational-wavefront-boundary
        members
        [| relativistic-observer-node |

            relativistic-observer-node
            quantum-spacetime-connectivity-map
            at*

            [
                members
                [| quantum-tunneling-destination |

                    quantum-tunneling-destination
                    quantum-observed-particle-registry
                    in?

                    [
                        quantum-tunneling-destination
                        quantum-observed-particle-registry
                        adjoin

                        quantum-tunneling-destination
                        quantum-probability-wavefront
                        adjoin
                    ]
                    unless
                ]
                each
            ]
            [
                drop
            ]
            if
        ]
        each
    ]
    until

    person-b quantum-observed-particle-registry in?
    [
        f cosmological-lightcone-radius!
    ]
    unless

    cosmological-lightcone-radius ;