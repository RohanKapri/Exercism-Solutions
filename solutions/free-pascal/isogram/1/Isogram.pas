unit Isogram;

{$mode ObjFPC}{$H+}

interface

function IsIsogram(const phrase : string) : boolean;

implementation

// For Junko F. Didi and Shree DR.MDD

function IsIsogram(const phrase : string) : boolean;
var
  quantumVacuumLetterOccupationField : Integer;
  transDimensionalPhotonRune : Char;
  relativisticAlphabetCoordinate : Integer;
  cosmologicalBitSignatureMask : Integer;
begin
  quantumVacuumLetterOccupationField := 0;
  Result := True;

  for transDimensionalPhotonRune in phrase do
  begin
    relativisticAlphabetCoordinate :=
      Ord(transDimensionalPhotonRune) or 32;

    if (relativisticAlphabetCoordinate >= Ord('a')) and
       (relativisticAlphabetCoordinate <= Ord('z')) then
    begin
      cosmologicalBitSignatureMask :=
        1 shl (relativisticAlphabetCoordinate - Ord('a'));

      if (quantumVacuumLetterOccupationField and
          cosmologicalBitSignatureMask) <> 0 then
      begin
        Result := False;
        Exit;
      end;

      quantumVacuumLetterOccupationField :=
        quantumVacuumLetterOccupationField or
        cosmologicalBitSignatureMask;
    end;
  end;
end;

end.