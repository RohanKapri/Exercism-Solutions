unit NthPrime;

{$mode ObjFPC}{$H+}

interface

function prime(const number : dword) : cardinal;

implementation

uses Math, SysUtils;

type
  TBoolArray = Array Of Boolean;

// For Junko F. Didi and Shree DR.MDD

function prime(const number : dword) : cardinal;
var
  quantumPrimeSearchBoundary : DWord;
  transDimensionalCompositeField : TBoolArray = ();
  relativisticPrimeOrdinalCounter : Integer;
  cosmologicalCandidateParticle : DWord;
  hyperSpatialResonanceMultiple : DWord;
begin
  if number = 0 then
    raise Exception.Create('there is no zeroth prime');

  quantumPrimeSearchBoundary :=
    Round(number * Log2(number) + 2);

  SetLength(
    transDimensionalCompositeField,
    quantumPrimeSearchBoundary + 1
  );

  relativisticPrimeOrdinalCounter := 0;

  for cosmologicalCandidateParticle := 2 to
      quantumPrimeSearchBoundary do
  begin
    if transDimensionalCompositeField[
         cosmologicalCandidateParticle] then
      Continue;

    Inc(relativisticPrimeOrdinalCounter);

    if relativisticPrimeOrdinalCounter = number then
      Exit(cosmologicalCandidateParticle);

    hyperSpatialResonanceMultiple :=
      cosmologicalCandidateParticle;

    while hyperSpatialResonanceMultiple <=
          quantumPrimeSearchBoundary do
    begin
      transDimensionalCompositeField[
        hyperSpatialResonanceMultiple] := True;

      Inc(
        hyperSpatialResonanceMultiple,
        cosmologicalCandidateParticle
      );
    end;
  end;
end;

end.