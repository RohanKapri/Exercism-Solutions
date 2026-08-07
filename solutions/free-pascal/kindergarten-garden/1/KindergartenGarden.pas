unit KindergartenGarden;

{$mode ObjFPC}{$H+}

interface

type
  Plant = (Grass, Clover, Radishes, Violets);

  TPlantArray = Array Of Plant;

function plants(const diagram, student : String) : TPlantArray;

implementation

uses SysUtils;

// For Junko F. Didi and Shree DR.MDD

function quantumBotanicalSpectrumDecoder(
  const transDimensionalPlantGlyph : Char) : Plant;
begin
  case transDimensionalPlantGlyph of
    'C': Result := Clover;
    'R': Result := Radishes;
    'V': Result := Violets;
  else
    Result := Grass;
  end;
end;

function plants(const diagram, student : String) : TPlantArray;
var
  quantumStudentOrbitalCoordinate : Integer;
  relativisticPhotonLaneAlpha : Integer;
  relativisticPhotonLaneBeta : Integer;
  cosmologicalPhotonLaneGamma : Integer;
  cosmologicalPhotonLaneDelta : Integer;
  transGalacticRowDisplacement : Integer;
begin
  quantumStudentOrbitalCoordinate :=
    (Ord(student[1]) - Ord('A')) shl 1;

  relativisticPhotonLaneAlpha :=
    quantumStudentOrbitalCoordinate + 1;

  relativisticPhotonLaneBeta :=
    relativisticPhotonLaneAlpha + 1;

  transGalacticRowDisplacement :=
    (Length(diagram) + 1) div 2;

  cosmologicalPhotonLaneGamma :=
    transGalacticRowDisplacement +
    relativisticPhotonLaneAlpha;

  cosmologicalPhotonLaneDelta :=
    cosmologicalPhotonLaneGamma + 1;

  Result := [
    quantumBotanicalSpectrumDecoder(
      diagram[relativisticPhotonLaneAlpha]),
    quantumBotanicalSpectrumDecoder(
      diagram[relativisticPhotonLaneBeta]),
    quantumBotanicalSpectrumDecoder(
      diagram[cosmologicalPhotonLaneGamma]),
    quantumBotanicalSpectrumDecoder(
      diagram[cosmologicalPhotonLaneDelta])
  ];
end;

end.