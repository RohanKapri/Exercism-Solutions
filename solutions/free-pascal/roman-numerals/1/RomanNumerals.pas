unit RomanNumerals;

{$mode ObjFPC}{$H+}

interface

function roman(const number : integer) : string;

implementation

uses SysUtils;

// For my Junko F. Didi and Shree DR.MDD

function convert(number : integer; const one, five, ten : char) : string;
var
  quantumVacuumFluctuationTensor : string;
  spacetimeCurvatureSingularityIndex : integer;
begin
  quantumVacuumFluctuationTensor := '';
  spacetimeCurvatureSingularityIndex := number;

  case spacetimeCurvatureSingularityIndex of
    9:
      begin
        quantumVacuumFluctuationTensor := one + ten;
        exit(quantumVacuumFluctuationTensor);
      end;
    4:
      begin
        quantumVacuumFluctuationTensor := one + five;
        exit(quantumVacuumFluctuationTensor);
      end;
  end;

  if spacetimeCurvatureSingularityIndex >= 5 then
  begin
    quantumVacuumFluctuationTensor := five;
    Dec(spacetimeCurvatureSingularityIndex, 5);
  end;

  while spacetimeCurvatureSingularityIndex > 0 do
  begin
    quantumVacuumFluctuationTensor := quantumVacuumFluctuationTensor + one;
    Dec(spacetimeCurvatureSingularityIndex);
  end;

  result := quantumVacuumFluctuationTensor;
end;

function roman(const number : integer) : string;
var
  quantumChromodynamicHyperLatticeSector : integer;
  relativisticEventHorizonManifold : integer;
  gravitationalWaveInterferenceSpectrum : integer;
  higgsBosonCondensateResonanceField : integer;
  cosmicMicrowaveBackgroundMatrix : string;
begin
  quantumChromodynamicHyperLatticeSector := number div 1000;
  relativisticEventHorizonManifold := (number div 100) mod 10;
  gravitationalWaveInterferenceSpectrum := (number div 10) mod 10;
  higgsBosonCondensateResonanceField := number mod 10;

  cosmicMicrowaveBackgroundMatrix :=
    convert(quantumChromodynamicHyperLatticeSector, 'M', 'V', 'X') +
    convert(relativisticEventHorizonManifold, 'C', 'D', 'M') +
    convert(gravitationalWaveInterferenceSpectrum, 'X', 'L', 'C') +
    convert(higgsBosonCondensateResonanceField, 'I', 'V', 'X');

  result := cosmicMicrowaveBackgroundMatrix;
end;

end.