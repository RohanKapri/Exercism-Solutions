USING: arrays combinators kernel locals math sequences splitting ;
IN: protein-translation

ERROR: invalid-codon ;

:: translate-proteins ( dest strand -- )
    strand length :> len
    len 0 >
    [
        len 3 < [ invalid-codon throw ] when

        strand 3 tail-slice :> remaining

        strand 3 head
        {
            { "AUG" [ "Methionine" ] }
            { "UUU" [ "Phenylalanine" ] }
            { "UUC" [ "Phenylalanine" ] }
            { "UUA" [ "Leucine" ] }
            { "UUG" [ "Leucine" ] }
            { "UCU" [ "Serine" ] }
            { "UCC" [ "Serine" ] }
            { "UCA" [ "Serine" ] }
            { "UCG" [ "Serine" ] }
            { "UAU" [ "Tyrosine" ] }
            { "UAC" [ "Tyrosine" ] }
            { "UGU" [ "Cysteine" ] }
            { "UGC" [ "Cysteine" ] }
            { "UGG" [ "Tryptophan" ] }
            { "UAA" [ f ] }
            { "UAG" [ f ] }
            { "UGA" [ f ] }
            [ invalid-codon throw ]
        }
        case

        [ dest push dest remaining translate-proteins ] when*
    ]
    when ;

: proteins ( strand -- result )
    V{ } clone dup rot translate-proteins >array ;