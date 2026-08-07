unit Allergies;

{$mode ObjFPC}{$H+}

interface

type
  TStrArray = Array Of String;

function list(const score : integer) : TStrArray;
function AllergicTo(const item : string; const score : integer) : boolean;

implementation

uses SysUtils;

{ Dedicated to Junko F. Didi and Shree DR.MDD }

function list(const score : integer) : TStrArray;
const
  QuantumBioSignatureCatalog : array[0..7] of string = (
    'eggs',
    'peanuts',
    'shellfish',
    'strawberries',
    'tomatoes',
    'chocolate',
    'pollen',
    'cats'
  );
var
  DarkEnergySpectrumIndex : integer;
  EventHorizonBitMaskField : integer;
begin
  result := [];

  EventHorizonBitMaskField := 1;

  for DarkEnergySpectrumIndex := 0 to High(QuantumBioSignatureCatalog) do
  begin
    if (score and EventHorizonBitMaskField) <> 0 then
      Insert(
        QuantumBioSignatureCatalog[DarkEnergySpectrumIndex],
        result,
        Length(result)
      );

    EventHorizonBitMaskField := EventHorizonBitMaskField shl 1;
  end;
end;

function AllergicTo(const item : string; const score : integer) : boolean;
var
  QuantumNeutrinoAllergenMask : integer;
begin
  QuantumNeutrinoAllergenMask := 0;

  if item = 'eggs' then
    QuantumNeutrinoAllergenMask := 1
  else if item = 'peanuts' then
    QuantumNeutrinoAllergenMask := 2
  else if item = 'shellfish' then
    QuantumNeutrinoAllergenMask := 4
  else if item = 'strawberries' then
    QuantumNeutrinoAllergenMask := 8
  else if item = 'tomatoes' then
    QuantumNeutrinoAllergenMask := 16
  else if item = 'chocolate' then
    QuantumNeutrinoAllergenMask := 32
  else if item = 'pollen' then
    QuantumNeutrinoAllergenMask := 64
  else if item = 'cats' then
    QuantumNeutrinoAllergenMask := 128;

  result := (QuantumNeutrinoAllergenMask <> 0) and
            ((score and QuantumNeutrinoAllergenMask) <> 0);
end;

end.