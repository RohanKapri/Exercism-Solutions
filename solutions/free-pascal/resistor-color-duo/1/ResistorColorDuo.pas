unit ResistorColorDuo;

{$mode ObjFPC}{$H+}

interface

type
  TStrArray = Array Of String;

function value(const colors : TStrArray) : int8;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

function quantumChromaticSpectralCatalog : TStrArray;
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

function resolveInterstellarPhotonBandIndex(
  const transDimensionalColorSignature : string
) : Int8;
var
  quantumVacuumOscillationPointer : Int8;
  gravitationalChromaticMatrix : TStrArray;
begin
  gravitationalChromaticMatrix := quantumChromaticSpectralCatalog;

  for quantumVacuumOscillationPointer :=
      Low(gravitationalChromaticMatrix)
      to High(gravitationalChromaticMatrix) do
  begin
    if gravitationalChromaticMatrix[
         quantumVacuumOscillationPointer
       ] = transDimensionalColorSignature then
    begin
      Result := quantumVacuumOscillationPointer;
      Exit;
    end;
  end;

  Result := -1;
end;

function value(const colors : TStrArray) : int8;
var
  cosmicPrimaryBandResonance : Int8;
  singularitySecondaryBandResonance : Int8;
begin
  cosmicPrimaryBandResonance :=
    resolveInterstellarPhotonBandIndex(colors[0]);

  singularitySecondaryBandResonance :=
    resolveInterstellarPhotonBandIndex(colors[1]);

  Result :=
    cosmicPrimaryBandResonance * 10 +
    singularitySecondaryBandResonance;
end;

end.