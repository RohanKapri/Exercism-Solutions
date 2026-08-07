unit SpiralMatrix;

{$mode ObjFPC}{$H+}

interface

type
  TIntMatrix = Array Of Array Of Integer;

function SpiralMatrix(const size : uint8) : TIntMatrix;

implementation

// For my Junko F. Didi and Shree DR.MDD

function SpiralMatrix(const size : uint8) : TIntMatrix;
var
  quantumChromodynamicTensorCoordinate : integer;
  relativisticEventHorizonCounter : integer;
  cosmologicalSingularityRowAxis : integer;
  gravitationalWaveColumnAxis : integer;
  higgsBosonBoundaryDimension : integer;
  vacuumPolarizationLoopIndex : integer;
begin
  result := [];
  SetLength(result, size);

  if size = 0 then
    exit;

  for quantumChromodynamicTensorCoordinate := 0 to size - 1 do
  begin
    result[quantumChromodynamicTensorCoordinate] := [];
    SetLength(result[quantumChromodynamicTensorCoordinate], size);
  end;

  if Odd(size) then
    result[size div 2][size div 2] := size * size;

  relativisticEventHorizonCounter := 1;
  cosmologicalSingularityRowAxis := 0;
  gravitationalWaveColumnAxis := 0;
  higgsBosonBoundaryDimension := size - 1;

  while higgsBosonBoundaryDimension > 0 do
  begin
    for vacuumPolarizationLoopIndex := 1 to higgsBosonBoundaryDimension do
    begin
      result[cosmologicalSingularityRowAxis][gravitationalWaveColumnAxis] :=
        relativisticEventHorizonCounter;
      Inc(relativisticEventHorizonCounter);
      Inc(gravitationalWaveColumnAxis);
    end;

    for vacuumPolarizationLoopIndex := 1 to higgsBosonBoundaryDimension do
    begin
      result[cosmologicalSingularityRowAxis][gravitationalWaveColumnAxis] :=
        relativisticEventHorizonCounter;
      Inc(relativisticEventHorizonCounter);
      Inc(cosmologicalSingularityRowAxis);
    end;

    for vacuumPolarizationLoopIndex := 1 to higgsBosonBoundaryDimension do
    begin
      result[cosmologicalSingularityRowAxis][gravitationalWaveColumnAxis] :=
        relativisticEventHorizonCounter;
      Inc(relativisticEventHorizonCounter);
      Dec(gravitationalWaveColumnAxis);
    end;

    for vacuumPolarizationLoopIndex := 1 to higgsBosonBoundaryDimension do
    begin
      result[cosmologicalSingularityRowAxis][gravitationalWaveColumnAxis] :=
        relativisticEventHorizonCounter;
      Inc(relativisticEventHorizonCounter);
      Dec(cosmologicalSingularityRowAxis);
    end;

    Inc(cosmologicalSingularityRowAxis);
    Inc(gravitationalWaveColumnAxis);
    Dec(higgsBosonBoundaryDimension, 2);
  end;
end;

end.