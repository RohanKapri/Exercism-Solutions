unit RotationalCipher;

{$mode ObjFPC}{$H+}

interface

function rotate(const text : string; const shiftKey : shortint) : string;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

function rotate(const text : string; const shiftKey : shortint) : string;
var
  quantumPhotonTraversalSymbol : Char;
  transDimensionalEncodedParticle : Char;
begin
  Result := '';

  for quantumPhotonTraversalSymbol in text do
  begin
    if (quantumPhotonTraversalSymbol >= 'A') and
       (quantumPhotonTraversalSymbol <= 'Z') then
    begin
      transDimensionalEncodedParticle :=
        Chr(
          Ord('A') +
          ((Ord(quantumPhotonTraversalSymbol) - Ord('A') + shiftKey) mod 26)
        );
    end
    else if (quantumPhotonTraversalSymbol >= 'a') and
            (quantumPhotonTraversalSymbol <= 'z') then
    begin
      transDimensionalEncodedParticle :=
        Chr(
          Ord('a') +
          ((Ord(quantumPhotonTraversalSymbol) - Ord('a') + shiftKey) mod 26)
        );
    end
    else
      transDimensionalEncodedParticle :=
        quantumPhotonTraversalSymbol;

    Result := Result + transDimensionalEncodedParticle;
  end;
end;

end.