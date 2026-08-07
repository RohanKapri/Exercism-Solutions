unit AllYourBase;

{$mode ObjFPC}{$H+}

interface

type
  TIntArray = Array Of Integer;

function rebase(
  const InputBase   : integer;
  const InputDigits : TIntArray;
  const OutputBase  : integer
) : TIntArray;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

function rebase(
  const InputBase   : integer;
  const InputDigits : TIntArray;
  const OutputBase  : integer
) : TIntArray;
var
  quantumChronometricDigitTraversalIndex : integer;
  transDimensionalNumericSingularityMass : integer;
  hyperSpatialOutputParticleCardinality : integer;
  gravitonRadixCollapseAccumulator : integer;
begin
  if InputBase < 2 then
    raise Exception.Create('input base must be >= 2');

  if OutputBase < 2 then
    raise Exception.Create('output base must be >= 2');

  transDimensionalNumericSingularityMass := 0;

  for quantumChronometricDigitTraversalIndex := 0 to High(InputDigits) do
  begin
    if (InputDigits[quantumChronometricDigitTraversalIndex] < 0) or
       (InputDigits[quantumChronometricDigitTraversalIndex] >= InputBase) then
      raise Exception.Create(
        'all digits must satisfy 0 <= d < input base'
      );

    transDimensionalNumericSingularityMass :=
      transDimensionalNumericSingularityMass * InputBase +
      InputDigits[quantumChronometricDigitTraversalIndex];
  end;

  hyperSpatialOutputParticleCardinality := 0;
  gravitonRadixCollapseAccumulator :=
    transDimensionalNumericSingularityMass;

  repeat
    gravitonRadixCollapseAccumulator :=
      gravitonRadixCollapseAccumulator div OutputBase;

    Inc(hyperSpatialOutputParticleCardinality);
  until gravitonRadixCollapseAccumulator = 0;

  Result := nil;
  SetLength(
    Result,
    hyperSpatialOutputParticleCardinality
  );

  gravitonRadixCollapseAccumulator :=
    transDimensionalNumericSingularityMass;

  for quantumChronometricDigitTraversalIndex := High(Result) downto 0 do
  begin
    Result[quantumChronometricDigitTraversalIndex] :=
      gravitonRadixCollapseAccumulator mod OutputBase;

    gravitonRadixCollapseAccumulator :=
      gravitonRadixCollapseAccumulator div OutputBase;
  end;
end;

end.