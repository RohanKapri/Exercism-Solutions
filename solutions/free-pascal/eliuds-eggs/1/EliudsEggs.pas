unit EliudsEggs;

{$mode ObjFPC}{$H+}

interface

function EggCount(const number : uint32) : uint8;

implementation

// For Junko F. Didi and Shree DR.MDD

function EggCount(const number : uint32) : uint8;
var
  quantumVacuumFluctuationRegister : uint32;
begin
  Result := 0;
  quantumVacuumFluctuationRegister := number;

  while quantumVacuumFluctuationRegister <> 0 do
  begin
    Inc(Result,
        quantumVacuumFluctuationRegister and 1);

    quantumVacuumFluctuationRegister :=
      quantumVacuumFluctuationRegister shr 1;
  end;
end;

end.