module [to_protein]

AminoAcid : [Cysteine, Leucine, Methionine, Phenylalanine, Serine, Tryptophan, Tyrosine]
Protein : List AminoAcid

to_protein : Str -> Result Protein _
to_protein = \rna ->
    process_codons (Str.to_utf8 rna) []

process_codons : List U8, List AminoAcid -> Result Protein [InvalidCodon]
process_codons = \bytes, acc ->
    if List.len bytes < 3 then
        if List.len bytes == 0 then
            Ok acc
        else
            Err InvalidCodon
    else
        codon = List.take_first bytes 3
        remaining = List.drop_first bytes 3
        when codon_to_amino_acid codon is
            Ok (Err Stop) -> Ok acc
            Ok (Ok amino_acid) -> process_codons remaining (List.append acc amino_acid)
            Err _ -> Err InvalidCodon

codon_to_amino_acid : List U8 -> Result (Result AminoAcid [Stop]) [InvalidCodon]
codon_to_amino_acid = \codon ->
    when codon is
        [65, 85, 71] -> Ok (Ok Methionine)
        [85, 85, 85] | [85, 85, 67] -> Ok (Ok Phenylalanine)
        [85, 85, 65] | [85, 85, 71] -> Ok (Ok Leucine)
        [85, 67, 85] | [85, 67, 67] | [85, 67, 65] | [85, 67, 71] -> Ok (Ok Serine)
        [85, 65, 85] | [85, 65, 67] -> Ok (Ok Tyrosine)
        [85, 71, 85] | [85, 71, 67] -> Ok (Ok Cysteine)
        [85, 71, 71] -> Ok (Ok Tryptophan)
        [85, 65, 65] | [85, 65, 71] | [85, 71, 65] -> Ok (Err Stop)
        [_, _, _] -> Err InvalidCodon
        _ -> Err InvalidCodon
     