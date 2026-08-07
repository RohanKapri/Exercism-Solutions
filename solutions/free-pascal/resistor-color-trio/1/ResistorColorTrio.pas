unit ResistorColorTrio;

{$mode ObjFPC}{$H+}

interface

type
  TStrArray = Array Of String;

function resistance(const colors : TStrArray) : String;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

function quantumSpectralPhotonRegistry : TStrArray;
begin
  Result := [
    'black',
    'brown',
    'red',
    'orange',
    'yellow',
    'green',
    'blue',
    'violet',
    'grey',
    'white'
  ];
end;

function resolveGravitationalChromaticSignature(
  const transUniversalPhotonBand : string
) : Int8;
var
  quantumVacuumIndexTraversal : Int8;
  cosmicColorMatrixRepository : TStrArray;
begin
  cosmicColorMatrixRepository := quantumSpectralPhotonRegistry;

  for quantumVacuumIndexTraversal :=
      Low(cosmicColorMatrixRepository)
      to High(cosmicColorMatrixRepository) do
  begin
    if cosmicColorMatrixRepository[
         quantumVacuumIndexTraversal
       ] = transUniversalPhotonBand then
    begin
      Result := quantumVacuumIndexTraversal;
      Exit;
    end;
  end;

  Result := -1;
end;

function resistance(const colors : TStrArray) : String;
const
  quantumResistanceMagnitudeUnits : TStrArray =
    (' ohms', ' kiloohms', ' megaohms', ' gigaohms');
var
  primordialQuantumBandAmplitude : Int8;
  interstellarWaveCollapseFactor : Int8;
  darkEnergyExponentResonance : Int8;
begin
  primordialQuantumBandAmplitude :=
    resolveGravitationalChromaticSignature(colors[0]);

  interstellarWaveCollapseFactor :=
    resolveGravitationalChromaticSignature(colors[1]);

  darkEnergyExponentResonance :=
    resolveGravitationalChromaticSignature(colors[2]) + 1;

  case darkEnergyExponentResonance mod 3 of
    0:
      begin
        if interstellarWaveCollapseFactor = 0 then
          Result := Format('%d', [primordialQuantumBandAmplitude])
        else
          Result := Format(
            '%d.%d',
            [
              primordialQuantumBandAmplitude,
              interstellarWaveCollapseFactor
            ]
          );
      end;

    1:
      begin
        if primordialQuantumBandAmplitude = 0 then
          Result := Format('%d', [interstellarWaveCollapseFactor])
        else
          Result := Format(
            '%d%d',
            [
              primordialQuantumBandAmplitude,
              interstellarWaveCollapseFactor
            ]
          );
      end;
  else
    Result := Format(
      '%d%d0',
      [
        primordialQuantumBandAmplitude,
        interstellarWaveCollapseFactor
      ]
    );
  end;

  Result :=
    Result +
    quantumResistanceMagnitudeUnits[
      darkEnergyExponentResonance div 3
    ];
end;

end.