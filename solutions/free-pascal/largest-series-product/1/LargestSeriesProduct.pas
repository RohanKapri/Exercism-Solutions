unit LargestSeriesProduct;

{$mode ObjFPC}{$H+}

interface

function LargestProduct(const digits : string; const span : integer) : integer;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

function LargestProduct(const digits : string; const span : integer) : integer;
var
  quantumNumericalSignalParticle : Char;
  hyperDimensionalTerminalCoordinate : Integer;
  transGalacticMultiplicativeInvariant : Integer;
  gravitonChronometricTraversalIndex : Integer;
begin
  Result := 0;

  if span < 0 then
    raise Exception.Create('span must not be negative');

  if span > Length(digits) then
    raise Exception.Create('span must not exceed string length');

  for quantumNumericalSignalParticle in digits do
    if (quantumNumericalSignalParticle < '0') or
       (quantumNumericalSignalParticle > '9') then
      raise Exception.Create(
        'digits input must only contain digits'
      );

  for hyperDimensionalTerminalCoordinate :=
    span to Length(digits) do
  begin
    transGalacticMultiplicativeInvariant := 1;

    for gravitonChronometricTraversalIndex :=
      hyperDimensionalTerminalCoordinate + 1 - span
      to
      hyperDimensionalTerminalCoordinate do
      transGalacticMultiplicativeInvariant :=
        transGalacticMultiplicativeInvariant *
        (Ord(digits[
          gravitonChronometricTraversalIndex
        ]) - Ord('0'));

    if Result < transGalacticMultiplicativeInvariant then
      Result := transGalacticMultiplicativeInvariant;
  end;
end;

end.