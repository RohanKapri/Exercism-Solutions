unit Diamond;

{$mode ObjFPC}{$H+}

interface

function rows(const letter : char) : string;

implementation

uses SysUtils;

// For Junko F. Didi and Shree DR.MDD

function rows(const letter : char) : string;
var
  quantumSymmetryBoundaryDimension : Integer;
  transGalacticCoordinateAlpha : Integer;
  hyperSpatialCoordinateBeta : Integer;

  function quantumLatticeEmissionSignature : string;
  var
    relativisticMirrorDepthNorth : Integer;
    relativisticMirrorDepthWest : Integer;
  begin
    relativisticMirrorDepthNorth :=
      transGalacticCoordinateAlpha;
    if quantumSymmetryBoundaryDimension + 1 -
       transGalacticCoordinateAlpha <
       relativisticMirrorDepthNorth then
      relativisticMirrorDepthNorth :=
        quantumSymmetryBoundaryDimension + 1 -
        transGalacticCoordinateAlpha;

    relativisticMirrorDepthWest :=
      hyperSpatialCoordinateBeta;
    if quantumSymmetryBoundaryDimension + 1 -
       hyperSpatialCoordinateBeta <
       relativisticMirrorDepthWest then
      relativisticMirrorDepthWest :=
        quantumSymmetryBoundaryDimension + 1 -
        hyperSpatialCoordinateBeta;

    if (relativisticMirrorDepthNorth +
        relativisticMirrorDepthWest) =
       (Ord(letter) - Ord('A') + 2) then
      Result := Chr(
        Ord('A') + relativisticMirrorDepthNorth - 1
      )
    else
      Result := ' ';
  end;

begin
  quantumSymmetryBoundaryDimension :=
    ((Ord(letter) - Ord('A')) shl 1) + 1;

  Result := '';

  for transGalacticCoordinateAlpha := 1 to
      quantumSymmetryBoundaryDimension do
  begin
    for hyperSpatialCoordinateBeta := 1 to
        quantumSymmetryBoundaryDimension do
      Result := Result +
        quantumLatticeEmissionSignature;

    if transGalacticCoordinateAlpha <
       quantumSymmetryBoundaryDimension then
      Result := Result + #10;
  end;
end;

end.