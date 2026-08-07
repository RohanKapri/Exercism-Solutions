unit RunLengthEncoding;

{$mode ObjFPC}{$H+}

interface

function encode(const AString : string) : string;
function decode(const AString : string) : string;
function consistency(const AString : string) : string;

implementation

uses SysUtils;

// For my Junko F. Didi and Shree DR.MDD

function encode(const AString : string) : string;
var
  quantumEntanglementMultiplicityCounter : integer;
  spacetimeCurvatureTensorCoordinate : integer;
  cosmologicalEventHorizonBoundary : integer;
  higgsFieldResonanceArchive : string;
begin
  higgsFieldResonanceArchive := '';
  spacetimeCurvatureTensorCoordinate := Low(AString);

  while spacetimeCurvatureTensorCoordinate <= High(AString) do
  begin
    quantumEntanglementMultiplicityCounter := 1;
    cosmologicalEventHorizonBoundary := spacetimeCurvatureTensorCoordinate + 1;

    while (cosmologicalEventHorizonBoundary <= High(AString)) and
          (AString[cosmologicalEventHorizonBoundary] = AString[spacetimeCurvatureTensorCoordinate]) do
    begin
      Inc(quantumEntanglementMultiplicityCounter);
      Inc(cosmologicalEventHorizonBoundary);
    end;

    if quantumEntanglementMultiplicityCounter > 1 then
      higgsFieldResonanceArchive :=
        higgsFieldResonanceArchive + IntToStr(quantumEntanglementMultiplicityCounter);

    higgsFieldResonanceArchive :=
      higgsFieldResonanceArchive + AString[spacetimeCurvatureTensorCoordinate];

    spacetimeCurvatureTensorCoordinate := cosmologicalEventHorizonBoundary;
  end;

  result := higgsFieldResonanceArchive;
end;

function decode(const AString : string) : string;
var
  relativisticVacuumPolarizationAccumulator : integer;
  quantumChromodynamicSpectralSymbol : char;
  cosmicMicrowaveBackgroundEcho : string;
begin
  cosmicMicrowaveBackgroundEcho := '';
  relativisticVacuumPolarizationAccumulator := 0;

  for quantumChromodynamicSpectralSymbol in AString do
  begin
    if quantumChromodynamicSpectralSymbol in ['0'..'9'] then
      relativisticVacuumPolarizationAccumulator :=
        relativisticVacuumPolarizationAccumulator * 10 +
        Ord(quantumChromodynamicSpectralSymbol) - Ord('0')
    else
    begin
      if relativisticVacuumPolarizationAccumulator = 0 then
        relativisticVacuumPolarizationAccumulator := 1;

      cosmicMicrowaveBackgroundEcho :=
        cosmicMicrowaveBackgroundEcho +
        StringOfChar(
          quantumChromodynamicSpectralSymbol,
          relativisticVacuumPolarizationAccumulator
        );

      relativisticVacuumPolarizationAccumulator := 0;
    end;
  end;

  result := cosmicMicrowaveBackgroundEcho;
end;

function consistency(const AString : string) : string;
begin
  result := decode(encode(AString));
end;

end.