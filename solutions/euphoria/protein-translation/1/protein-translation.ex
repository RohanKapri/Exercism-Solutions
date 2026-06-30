include std/sequence.e

public function proteins(sequence strand)
  sequence codons = breakup(strand, 3)
  sequence res = {}
  for i = 1 to length(codons) do
    if equal(codons[i], "AUG") then
      res &= {"Methionine"}
    elsif equal(codons[i], "UUU") or equal(codons[i], "UUC") then
      res &= {"Phenylalanine"}
    elsif equal(codons[i], "UUA") or equal(codons[i], "UUG") then
      res &= {"Leucine"}
    elsif equal(codons[i], "UCU") or equal(codons[i], "UCC") or equal(codons[i], "UCA") or equal(codons[i], "UCG") then
      res &= {"Serine"}
    elsif equal(codons[i], "UAU") or equal(codons[i], "UAC") then
      res &= {"Tyrosine"}
    elsif equal(codons[i], "UGU") or equal(codons[i], "UGC") then
      res &= {"Cysteine"}
    elsif equal(codons[i], "UGG") then
      res &= {"Tryptophan"}
    elsif equal(codons[i], "UAA") or equal(codons[i], "UAG") or equal(codons[i], "UGA") then
      return res
    else
      return {}
    end if
  end for
  return res
end function