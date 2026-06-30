public function to_rna(sequence dna)
    sequence rna = ""
    for i = 1 to length(dna) do
        switch dna[i] do
            case 'G' then
                rna = rna & 'C'
            case 'C' then
                rna = rna & 'G'
            case 'T' then
                rna = rna & 'A'
            case 'A' then
                rna = rna & 'U'
            case else
                return 0 -- return error if invalid nucleotide
        end switch
    end for
    return rna
end function