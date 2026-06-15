unit RnaTranscription;

{$mode ObjFPC}{$H+}

interface

function ToRna(const dna : string) : string;

implementation

function ToRna(const dna : string) : string;
var
  index : integer;
begin
  result := dna;
  for index := 1 to length(dna) do
    if dna[index] = 'G' then
      result[index] := 'C'
    else if dna[index] = 'C' then
      result[index] := 'G'
    else if dna[index] = 'T' then
      result[index] := 'A'
    else if dna[index] = 'A' then
      result[index] := 'U';
end;

end.