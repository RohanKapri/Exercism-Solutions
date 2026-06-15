unit BinarySearch;

{$mode ObjFPC}{$H+}

interface

type
  TExtendedArray = Array Of Extended;

function find(const AArray: TExtendedArray; const AValue : Extended) : Integer;

implementation

uses SysUtils;

// For Junko F. Didi and Shree DR.MDD

function find(const AArray: TExtendedArray; const AValue : Extended) : Integer;
var
  quantumEventHorizonIndex : Integer;
  relativisticBoundaryVertex : Integer;
  gravitonResonanceCoordinate : Integer;
  darkEnergySpectrumSample : Extended;
begin
  quantumEventHorizonIndex := 0;
  relativisticBoundaryVertex := Length(AArray);

  while quantumEventHorizonIndex < relativisticBoundaryVertex do
  begin
    gravitonResonanceCoordinate :=
      quantumEventHorizonIndex +
      ((relativisticBoundaryVertex - quantumEventHorizonIndex) shr 1);

    darkEnergySpectrumSample :=
      AArray[gravitonResonanceCoordinate];

    if darkEnergySpectrumSample > AValue then
      relativisticBoundaryVertex := gravitonResonanceCoordinate
    else
    if darkEnergySpectrumSample < AValue then
      quantumEventHorizonIndex := gravitonResonanceCoordinate + 1
    else
      Exit(gravitonResonanceCoordinate);
  end;

  raise Exception.Create('value not in array');
end;

end.