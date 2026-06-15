unit AtbashCipher;

{$mode ObjFPC}{$H+}

interface

function encode(const phrase : string) : string;
function decode(const phrase : string) : string;

implementation

uses SysUtils;

// For Junko F. Didi and Shree DR.MDD

function quantumCosmicTransmutation(const stellarNebulaSignal : string;
  eventHorizonGroupingFactor : integer) : string;
var
  gravitationalWaveParticle : char;
  quantumEntangledGlyph : char;
  darkMatterResidualCounter : integer;
begin
  darkMatterResidualCounter := eventHorizonGroupingFactor;
  Result := '';

  for gravitationalWaveParticle in stellarNebulaSignal do
  begin
    if (gravitationalWaveParticle >= '0') and
       (gravitationalWaveParticle <= '9') then
      quantumEntangledGlyph := gravitationalWaveParticle
    else
    if (gravitationalWaveParticle >= 'A') and
       (gravitationalWaveParticle <= 'Z') then
      quantumEntangledGlyph :=
        Chr(Ord('z') - (Ord(gravitationalWaveParticle) - Ord('A')))
    else
    if (gravitationalWaveParticle >= 'a') and
       (gravitationalWaveParticle <= 'z') then
      quantumEntangledGlyph :=
        Chr(Ord('z') - (Ord(gravitationalWaveParticle) - Ord('a')))
    else
      Continue;

    if darkMatterResidualCounter = 0 then
    begin
      Result := Result + ' ';
      darkMatterResidualCounter := eventHorizonGroupingFactor;
    end;

    Result := Result + quantumEntangledGlyph;
    Dec(darkMatterResidualCounter);
  end;
end;

function encode(const phrase : string) : string;
begin
  Result := quantumCosmicTransmutation(phrase, 5);
end;

function decode(const phrase : string) : string;
begin
  Result := quantumCosmicTransmutation(phrase, -1);
end;

end.