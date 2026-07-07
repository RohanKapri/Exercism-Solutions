USING: assocs combinators kernel sequences strings ;
IN: nucleotide-count

ERROR: invalid-nucleotide ;

: nucleotide-counts ( strand -- counts )
    H{ { "A" 0 } { "T" 0 } { "C" 0 } { "G" 0 } } clone
    [
        '[
            1string _
            2dup key?
            [
                inc-at
            ]
            [
                invalid-nucleotide
            ]
            if
        ] each
    ]
    keep ;