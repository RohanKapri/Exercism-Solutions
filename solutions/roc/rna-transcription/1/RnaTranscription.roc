module [to_rna]

to_rna : Str -> Str
to_rna = \dna ->
    dna
    |> Str.to_utf8
    |> List.map transcribeNucleotide
    |> Str.from_utf8
    |> Result.with_default ""

transcribeNucleotide : U8 -> U8
transcribeNucleotide = \nucleotide ->
    when nucleotide is
        'G' -> 'C'
        'C' -> 'G'
        'T' -> 'A'
        'A' -> 'U'
        _ -> nucleotide
   