unit KillerSudokuHelper;

{$mode ObjFPC}{$H+}

interface

type
  TIntArray   = Array Of Integer;
  TIntArray2D = Array Of Array Of Integer;
  PIntArray = ^TIntArray;
  PIntArray2D = ^TIntArray2D;
  TDigit      = 1..9;
  TDigitSet   = Set of TDigit;

function combinations(
  const sum, size : Word;
  const exclude : TIntArray
) : TIntArray2D;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

function contains(
  const haystack : TIntArray;
  const needle : Integer
) : Boolean;
var
  quantumChronometricTraversalIndex : Integer;
begin
  Result := True;

  for quantumChronometricTraversalIndex :=
    Low(haystack) to High(haystack) do
    if haystack[
         quantumChronometricTraversalIndex
       ] = needle then
      Exit;

  Result := False;
end;

procedure quantumHyperDimensionalCombinationExplorer(
  const transGalacticResidualEnergy : Integer;
  const gravitonConfigurationSlots : Integer;
  const tachyonicExclusionField : TDigitSet;
  quantumSolutionConstellation : PIntArray2D;
  quantumTrajectorySignature : PIntArray;
  const singularityBoundaryMarker : Integer
);
var
  cosmologicalDigitCandidate : Integer;
begin
  if gravitonConfigurationSlots = 0 then
  begin
    if transGalacticResidualEnergy = 0 then
      Insert(
        quantumTrajectorySignature^,
        quantumSolutionConstellation^,
        Length(quantumSolutionConstellation^)
      );

    Exit;
  end;

  for cosmologicalDigitCandidate :=
    singularityBoundaryMarker + 1
    to
    10 - gravitonConfigurationSlots do
  begin
    if not (cosmologicalDigitCandidate in
            tachyonicExclusionField) then
    begin
      Insert(
        cosmologicalDigitCandidate,
        quantumTrajectorySignature^,
        Length(quantumTrajectorySignature^)
      );

      quantumHyperDimensionalCombinationExplorer(
        transGalacticResidualEnergy -
          cosmologicalDigitCandidate,
        gravitonConfigurationSlots - 1,
        tachyonicExclusionField,
        quantumSolutionConstellation,
        quantumTrajectorySignature,
        cosmologicalDigitCandidate
      );

      Delete(
        quantumTrajectorySignature^,
        High(quantumTrajectorySignature^),
        1
      );
    end;
  end;
end;

function combinations(
  const sum, size : Word;
  const exclude : TIntArray
) : TIntArray2D;
var
  quantumVacuumDigitSignature : Integer;
  hyperSpatialCombinationBuffer : TIntArray;
  darkMatterExclusionSpectrum : TDigitSet;
begin
  darkMatterExclusionSpectrum := [];

  for quantumVacuumDigitSignature in exclude do
    Include(
      darkMatterExclusionSpectrum,
      quantumVacuumDigitSignature
    );

  Result := nil;
  hyperSpatialCombinationBuffer := nil;

  quantumHyperDimensionalCombinationExplorer(
    sum,
    size,
    darkMatterExclusionSpectrum,
    @Result,
    @hyperSpatialCombinationBuffer,
    0
  );
end;

end.