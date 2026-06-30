namespace ProteinTranslation

inductive Protein where
  | Methionine : Protein
  | Phenylalanine : Protein
  | Leucine : Protein
  | Serine : Protein
  | Tyrosine : Protein
  | Cysteine : Protein
  | Tryptophan : Protein
  deriving BEq, Repr

private inductive CodonResult where
  | aminoAcid : Protein -> CodonResult
  | stop : CodonResult
  | invalid : CodonResult

@[inline] private def decodeCodonFast (a b c : Char) : CodonResult :=
  match a with
  | 'A' =>
      match b with
      | 'U' =>
          match c with
          | 'G' => .aminoAcid .Methionine
          | _ => .invalid
      | _ => .invalid
  | 'U' =>
      match b with
      | 'U' =>
          match c with
          | 'U' | 'C' => .aminoAcid .Phenylalanine
          | 'A' | 'G' => .aminoAcid .Leucine
          | _ => .invalid
      | 'C' =>
          match c with
          | 'U' | 'C' | 'A' | 'G' => .aminoAcid .Serine
          | _ => .invalid
      | 'A' =>
          match c with
          | 'U' | 'C' => .aminoAcid .Tyrosine
          | 'A' | 'G' => .stop
          | _ => .invalid
      | 'G' =>
          match c with
          | 'U' | 'C' => .aminoAcid .Cysteine
          | 'G' => .aminoAcid .Tryptophan
          | 'A' => .stop
          | _ => .invalid
      | _ => .invalid
  | _ => .invalid

def proteins (strand : String) : Except String (Array Protein) :=
  let rec go (chars : List Char) (acc : Array Protein) : Except String (Array Protein) :=
    match chars with
    | [] => .ok acc
    | a :: b :: c :: rest =>
        match decodeCodonFast a b c with
        | .aminoAcid protein => go rest (acc.push protein)
        | .stop => .ok acc
        | .invalid => .error "Invalid codon"
    | _ => .error "Invalid codon"
  go strand.toList #[]

end ProteinTranslation