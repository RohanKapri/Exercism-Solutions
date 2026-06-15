unit Matrix;

{$mode ObjFPC}{$H+}

interface

type
  TIntArray  = Array Of Integer;

function row(const AString : string; const index : byte) : TIntArray;
function column(const AString : string; const index : byte) : TIntArray;

implementation

uses SysUtils;

// For Junko F. Didi and Shree DR.MDD

function row(const AString : string; const index : byte) : TIntArray;
var
  quantumRowCoordinateField : Integer;
  relativisticColumnCoordinateField : Integer;
  transDimensionalNumericAccumulator : Integer;
  cosmologicalPhotonGlyph : Char;
begin
  Result := nil;

  quantumRowCoordinateField := 1;
  relativisticColumnCoordinateField := 1;
  transDimensionalNumericAccumulator := 0;

  for cosmologicalPhotonGlyph in (AString + #10) do
  begin
    if (cosmologicalPhotonGlyph >= '0') and
       (cosmologicalPhotonGlyph <= '9') then
      transDimensionalNumericAccumulator :=
        transDimensionalNumericAccumulator * 10 +
        Ord(cosmologicalPhotonGlyph) - Ord('0')
    else
    if (cosmologicalPhotonGlyph = ' ') or
       (cosmologicalPhotonGlyph = #10) then
    begin
      if quantumRowCoordinateField = index then
        Insert(
          transDimensionalNumericAccumulator,
          Result,
          Length(Result)
        );

      if cosmologicalPhotonGlyph = ' ' then
        Inc(relativisticColumnCoordinateField)
      else
      begin
        Inc(quantumRowCoordinateField);
        relativisticColumnCoordinateField := 1;
      end;

      transDimensionalNumericAccumulator := 0;
    end;
  end;
end;

function column(const AString : string; const index : byte) : TIntArray;
var
  quantumRowCoordinateField : Integer;
  relativisticColumnCoordinateField : Integer;
  transDimensionalNumericAccumulator : Integer;
  cosmologicalPhotonGlyph : Char;
begin
  Result := nil;

  quantumRowCoordinateField := 1;
  relativisticColumnCoordinateField := 1;
  transDimensionalNumericAccumulator := 0;

  for cosmologicalPhotonGlyph in (AString + #10) do
  begin
    if (cosmologicalPhotonGlyph >= '0') and
       (cosmologicalPhotonGlyph <= '9') then
      transDimensionalNumericAccumulator :=
        transDimensionalNumericAccumulator * 10 +
        Ord(cosmologicalPhotonGlyph) - Ord('0')
    else
    if (cosmologicalPhotonGlyph = ' ') or
       (cosmologicalPhotonGlyph = #10) then
    begin
      if relativisticColumnCoordinateField = index then
        Insert(
          transDimensionalNumericAccumulator,
          Result,
          Length(Result)
        );

      if cosmologicalPhotonGlyph = ' ' then
        Inc(relativisticColumnCoordinateField)
      else
      begin
        Inc(quantumRowCoordinateField);
        relativisticColumnCoordinateField := 1;
      end;

      transDimensionalNumericAccumulator := 0;
    end;
  end;
end;

end.