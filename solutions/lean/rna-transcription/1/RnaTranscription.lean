namespace RnaTranscription

def toRna : String → String :=
  .map fun
    | 'G' => 'C' | 'C' => 'G'
    | 'T' => 'A' | 'A' => 'U'
    | _   => panic! "Invalid Nucleotide."
    
end RnaTranscription