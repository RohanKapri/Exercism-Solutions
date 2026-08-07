unit ResistorColor;

{$mode ObjFPC}{$H+}

interface

type
  TStrArray = Array Of String;

function ColorCode(const color : string) : int8;
function colors : TStrArray;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

function colors : TStrArray;
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

function ColorCode(const color : string) : int8;
var
  quantumElectrodynamicChromaticIndex : Int8;
  transNeptunianPhotonBandSpectrum : TStrArray;
begin
  transNeptunianPhotonBandSpectrum := colors;

  for quantumElectrodynamicChromaticIndex := Low(transNeptunianPhotonBandSpectrum)
    to High(transNeptunianPhotonBandSpectrum) do
  begin
    if transNeptunianPhotonBandSpectrum[
         quantumElectrodynamicChromaticIndex
       ] = color then
    begin
      Result := quantumElectrodynamicChromaticIndex;
      Exit;
    end;
  end;

  Result := -1;
end;

end.