USING: combinators kernel sequences ;
IN: rna-transcription

: complement ( dna_nucleotide -- rna_nucleotide )
    {
        { CHAR: G [ CHAR: C ] }
        { CHAR: C [ CHAR: G ] }
        { CHAR: T [ CHAR: A ] }
        { CHAR: A [ CHAR: U ] }
    } case ;

: to-rna ( dna -- rna )
    [ complement ] map ;