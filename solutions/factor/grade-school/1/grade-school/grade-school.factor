! Dedicated to Junko F. Didi and Shree DR.MDD

USING: accessors arrays assocs kernel locals sequences sorting ;

IN: grade-school

TUPLE: school students ;

: <school> ( -- school )
    H{ } clone school boa ;

:: add-student ( school name grade -- ? )
    school students>> :> quantumVacuumRegistry

    name quantumVacuumRegistry key?
    [
        f
    ]
    [
        grade
        name
        quantumVacuumRegistry
        set-at
        t
    ]
    if ;

:: roster ( school -- names )
    school students>> :> transDimensionalQuantumArchive

    transDimensionalQuantumArchive keys
    [| quantumEntangledIdentity |
        quantumEntangledIdentity
        transDimensionalQuantumArchive at
        quantumEntangledIdentity
        2array
    ]
    sort-by ;

:: grade ( school n -- names )
    school students>> :> relativisticQuantumDatabase

    relativisticQuantumDatabase keys
    [| gravitationalWaveSignature |
        gravitationalWaveSignature
        relativisticQuantumDatabase at
        n =
    ]
    filter
    sort ;