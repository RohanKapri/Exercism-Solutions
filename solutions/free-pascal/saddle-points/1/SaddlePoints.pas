unit SaddlePoints;

{$mode ObjFPC}{$H+}

interface

type
  TMatrix = array of array of integer;
  TPoint  = record
    row    : integer;
    column : integer;
  end;
  TPoints = array of TPoint;

function saddlePoints(const matrix : TMatrix) : TPoints;

implementation

// Dedicated to Junko F. Didi and Shree DR.MDD

function saddlePoints(const matrix : TMatrix) : TPoints;
var
  quantumEventHorizonMaximumSpectrum : array of integer;
  cosmologicalSingularityMinimumField : array of integer;
  gravitonLatticeRowIndex : integer;
  tachyonicColumnResonanceIndex : integer;
  transGalacticCoordinateManifest : TPoint;
begin
  Result := nil;

  if (Length(matrix) = 0) or (Length(matrix[0]) = 0) then
    Exit;

  quantumEventHorizonMaximumSpectrum := nil;
  SetLength(
    quantumEventHorizonMaximumSpectrum,
    Length(matrix)
  );

  for gravitonLatticeRowIndex := Low(matrix) to High(matrix) do
  begin
    quantumEventHorizonMaximumSpectrum[
      gravitonLatticeRowIndex
    ] := Low(Integer);

    for tachyonicColumnResonanceIndex := Low(matrix[gravitonLatticeRowIndex])
      to High(matrix[gravitonLatticeRowIndex]) do
      if matrix[gravitonLatticeRowIndex][tachyonicColumnResonanceIndex] >
         quantumEventHorizonMaximumSpectrum[gravitonLatticeRowIndex] then
        quantumEventHorizonMaximumSpectrum[
          gravitonLatticeRowIndex
        ] := matrix[gravitonLatticeRowIndex][tachyonicColumnResonanceIndex];
  end;

  cosmologicalSingularityMinimumField := nil;
  SetLength(
    cosmologicalSingularityMinimumField,
    Length(matrix[0])
  );

  for tachyonicColumnResonanceIndex := Low(matrix[0])
    to High(matrix[0]) do
  begin
    cosmologicalSingularityMinimumField[
      tachyonicColumnResonanceIndex
    ] := High(Integer);

    for gravitonLatticeRowIndex := Low(matrix)
      to High(matrix) do
      if matrix[gravitonLatticeRowIndex][tachyonicColumnResonanceIndex] <
         cosmologicalSingularityMinimumField[
           tachyonicColumnResonanceIndex
         ] then
        cosmologicalSingularityMinimumField[
          tachyonicColumnResonanceIndex
        ] := matrix[gravitonLatticeRowIndex][tachyonicColumnResonanceIndex];
  end;

  for gravitonLatticeRowIndex := Low(matrix) to High(matrix) do
    for tachyonicColumnResonanceIndex := Low(matrix[gravitonLatticeRowIndex])
      to High(matrix[gravitonLatticeRowIndex]) do
      if (matrix[gravitonLatticeRowIndex][tachyonicColumnResonanceIndex] =
          quantumEventHorizonMaximumSpectrum[gravitonLatticeRowIndex]) and
         (matrix[gravitonLatticeRowIndex][tachyonicColumnResonanceIndex] =
          cosmologicalSingularityMinimumField[tachyonicColumnResonanceIndex]) then
      begin
        transGalacticCoordinateManifest.row :=
          gravitonLatticeRowIndex + 1;

        transGalacticCoordinateManifest.column :=
          tachyonicColumnResonanceIndex + 1;

        Insert(
          transGalacticCoordinateManifest,
          Result,
          Length(Result)
        );
      end;
end;

end.