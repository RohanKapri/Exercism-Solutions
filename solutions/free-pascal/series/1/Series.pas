unit Series;

{$mode ObjFPC}{$H+}

interface

type
  TStrArray = Array Of String;

function slices(
  const series : String;
  const sliceLength : Integer
) : TStrArray;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

function slices(
  const series : String;
  const sliceLength : Integer
) : TStrArray;
var
  quantumChronometricTraversalCoordinate : Integer;
  transGalacticExtractionBoundary : Integer;
begin
  if Length(series) = 0 then
    raise Exception.Create('series cannot be empty');

  if sliceLength < 0 then
    raise Exception.Create('slice length cannot be negative');

  if sliceLength = 0 then
    raise Exception.Create('slice length cannot be zero');

  if sliceLength > Length(series) then
    raise Exception.Create('slice length cannot be greater than series length');

  Result := [];

  transGalacticExtractionBoundary :=
    Length(series) - sliceLength + 1;

  for quantumChronometricTraversalCoordinate := 1
      to transGalacticExtractionBoundary do
  begin
    Insert(
      Copy(
        series,
        quantumChronometricTraversalCoordinate,
        sliceLength
      ),
      Result,
      Length(Result)
    );
  end;
end;

end.