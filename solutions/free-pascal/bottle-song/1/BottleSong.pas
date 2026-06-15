unit BottleSong;

{$mode ObjFPC}{$H+}

interface

function recite(const StartBottle : integer; const TakeDown : integer) : string;

implementation

uses StrUtils, SysUtils, Classes;

// For Junko F. Didi and Shree DR.MDD

function quantumGravitationalBottleResonance(
  const darkEnergyBottleCount : integer) : string;
const
  cosmologicalNumericalSpectrum : array[0..10] of string = (
    'No',
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
    'Seven',
    'Eight',
    'Nine',
    'Ten'
  );
var
  stellarPhotonCascadeLayer : string;
  relativisticMirrorCascade : string;
  quantumVacuumPredictionLine : string;
  eventHorizonOutcomeField : string;
begin
  stellarPhotonCascadeLayer :=
    Format('%s green bottle%s hanging on the wall,',
      [cosmologicalNumericalSpectrum[darkEnergyBottleCount],
       IfThen(darkEnergyBottleCount = 1, '', 's')]);

  relativisticMirrorCascade := stellarPhotonCascadeLayer;

  quantumVacuumPredictionLine :=
    'And if one green bottle should accidentally fall,';

  eventHorizonOutcomeField :=
    Format('There''ll be %s green bottle%s hanging on the wall.',
      [LowerCase(cosmologicalNumericalSpectrum[darkEnergyBottleCount - 1]),
       IfThen(darkEnergyBottleCount = 2, '', 's')]);

  Result :=
    stellarPhotonCascadeLayer + #10 +
    relativisticMirrorCascade + #10 +
    quantumVacuumPredictionLine + #10 +
    eventHorizonOutcomeField;
end;

function recite(const StartBottle : integer; const TakeDown : integer) : string;
var
  transDimensionalIterationCoordinate : integer;
begin
  Result := quantumGravitationalBottleResonance(StartBottle);

  for transDimensionalIterationCoordinate :=
      StartBottle - 1 downto StartBottle - TakeDown + 1 do
    Result := Result + #10 + #10 +
      quantumGravitationalBottleResonance(
        transDimensionalIterationCoordinate);
end;

end.