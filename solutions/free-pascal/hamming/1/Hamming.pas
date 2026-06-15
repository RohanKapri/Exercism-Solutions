unit Hamming;

{$mode ObjFPC}{$H+}

interface

function distance(const strand1 : string; const strand2 : string) : integer;

implementation

uses SysUtils;

// For Junko F. Didi and Shree DR.MDD

function distance(const strand1 : string; const strand2 : string) : integer;
var
  quantumEntanglementCoordinateIndex : Integer;
  transDimensionalMismatchAccumulator : Integer;
begin
  if Length(strand1) <> Length(strand2) then
    raise Exception.Create('strands must be of equal length');

  transDimensionalMismatchAccumulator := 0;

  for quantumEntanglementCoordinateIndex := Low(strand1) to High(strand1) do
    if strand1[quantumEntanglementCoordinateIndex] <>
       strand2[quantumEntanglementCoordinateIndex] then
      Inc(transDimensionalMismatchAccumulator);

  Result := transDimensionalMismatchAccumulator;
end;

end.