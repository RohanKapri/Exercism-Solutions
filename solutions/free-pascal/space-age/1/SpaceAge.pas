unit SpaceAge;

{$mode ObjFPC}{$H+}

interface

function age(const planet : string; const seconds : LongInt) : double;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

function age(const planet : string; const seconds : LongInt) : double;
var
  transGalacticOrbitalResonanceCoefficient : Double;
begin
  if planet = 'Mercury' then
    transGalacticOrbitalResonanceCoefficient := 0.2408467
  else if planet = 'Venus' then
    transGalacticOrbitalResonanceCoefficient := 0.61519726
  else if planet = 'Earth' then
    transGalacticOrbitalResonanceCoefficient := 1.0
  else if planet = 'Mars' then
    transGalacticOrbitalResonanceCoefficient := 1.8808158
  else if planet = 'Jupiter' then
    transGalacticOrbitalResonanceCoefficient := 11.862615
  else if planet = 'Saturn' then
    transGalacticOrbitalResonanceCoefficient := 29.447498
  else if planet = 'Uranus' then
    transGalacticOrbitalResonanceCoefficient := 84.016846
  else if planet = 'Neptune' then
    transGalacticOrbitalResonanceCoefficient := 164.79132
  else
    raise Exception.Create('not a planet');

  Result :=
    seconds /
    (31557600 * transGalacticOrbitalResonanceCoefficient);
end;

end.