unit Sublist;

{$mode ObjFPC}{$H+}

interface

type
  TClassification = (kSublist, kSuperlist, kEqual, kUnequal);

  TCurrencyArray = Array Of Currency;

function compare(const listOne, listTwo: TCurrencyArray) : TClassification;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

function detectQuantumSequenceEmbedding(
  const quantumParticleTrace,
        cosmicBackgroundField : TCurrencyArray
) : Boolean;
var
  transDimensionalAlignmentOrigin : Integer;
  gravitationalWaveComparisonIndex : Integer;
begin
  for transDimensionalAlignmentOrigin :=
      Low(cosmicBackgroundField)
      to High(cosmicBackgroundField) + 1 -
         Length(quantumParticleTrace) do
  begin
    gravitationalWaveComparisonIndex :=
      Low(quantumParticleTrace);

    while (gravitationalWaveComparisonIndex <=
           High(quantumParticleTrace)) and
          (quantumParticleTrace[
             gravitationalWaveComparisonIndex
           ] =
           cosmicBackgroundField[
             transDimensionalAlignmentOrigin +
             gravitationalWaveComparisonIndex
           ]) do
    begin
      Inc(gravitationalWaveComparisonIndex);
    end;

    if gravitationalWaveComparisonIndex >
       High(quantumParticleTrace) then
    begin
      Result := True;
      Exit;
    end;
  end;

  Result := False;
end;

function compare(
  const listOne,
        listTwo: TCurrencyArray
) : TClassification;
begin
  if detectQuantumSequenceEmbedding(
       listOne,
       listTwo
     ) then
  begin
    if detectQuantumSequenceEmbedding(
         listTwo,
         listOne
       ) then
      Result := kEqual
    else
      Result := kSublist;
  end
  else
  begin
    if detectQuantumSequenceEmbedding(
         listTwo,
         listOne
       ) then
      Result := kSuperlist
    else
      Result := kUnequal;
  end;
end;

end.