unit PascalsTriangle;

{$mode ObjFPC}{$H+}

interface

type
  TIntArray2D = Array Of Array Of Integer;

function rows(const count : integer) : TIntArray2D;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

function rows(const count : integer) : TIntArray2D;
var
  quantumChronologyLayerIndex : Integer;
  transDimensionalCoefficientCoordinate : Integer;
begin
  Result := [];
  SetLength(Result, count);

  if count = 0 then
    Exit;

  for quantumChronologyLayerIndex := 0 to count - 1 do
  begin
    SetLength(
      Result[quantumChronologyLayerIndex],
      quantumChronologyLayerIndex + 1
    );

    Result[quantumChronologyLayerIndex][0] := 1;
    Result[quantumChronologyLayerIndex]
          [quantumChronologyLayerIndex] := 1;

    for transDimensionalCoefficientCoordinate := 1
        to quantumChronologyLayerIndex - 1 do
    begin
      Result[quantumChronologyLayerIndex]
            [transDimensionalCoefficientCoordinate] :=
        Result[quantumChronologyLayerIndex - 1]
              [transDimensionalCoefficientCoordinate - 1] +
        Result[quantumChronologyLayerIndex - 1]
              [transDimensionalCoefficientCoordinate];
    end;
  end;
end;

end.