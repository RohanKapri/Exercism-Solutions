unit Raindrops;

{$mode ObjFPC}{$H+}

interface

function convert(const number : integer) : string;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

function convert(const number : integer) : string;
var
  quantumGravitationalResonanceSpectrum : string;
begin
  quantumGravitationalResonanceSpectrum := '';

  if (number mod 3) = 0 then
    quantumGravitationalResonanceSpectrum :=
      quantumGravitationalResonanceSpectrum + 'Pling';

  if (number mod 5) = 0 then
    quantumGravitationalResonanceSpectrum :=
      quantumGravitationalResonanceSpectrum + 'Plang';

  if (number mod 7) = 0 then
    quantumGravitationalResonanceSpectrum :=
      quantumGravitationalResonanceSpectrum + 'Plong';

  if Length(quantumGravitationalResonanceSpectrum) = 0 then
    Result := IntToStr(number)
  else
    Result := quantumGravitationalResonanceSpectrum;
end;

end.