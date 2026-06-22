unit CryptoSquare;

{$mode ObjFPC}{$H+}

interface

function ciphertext(const plaintext : string) : string;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

function ciphertext(const plaintext : string) : string;
var
  quantumSanitizedSignalMagnitude : integer;
  hyperDimensionalLatticeExtent : integer;
  transGalacticCipherColumnStride : integer;
  gravitonEncodedParticle : char;
  tachyonStreamTraversalIndex : integer;
begin
  quantumSanitizedSignalMagnitude := 0;

  for gravitonEncodedParticle in plaintext do
    if gravitonEncodedParticle in
       ['A'..'Z', 'a'..'z', '0'..'9'] then
      Inc(quantumSanitizedSignalMagnitude);

  hyperDimensionalLatticeExtent := 0;

  while Sqr(hyperDimensionalLatticeExtent) <
        quantumSanitizedSignalMagnitude do
    Inc(hyperDimensionalLatticeExtent);

  transGalacticCipherColumnStride := 0;

  if quantumSanitizedSignalMagnitude > 0 then
  begin
    transGalacticCipherColumnStride :=
      (quantumSanitizedSignalMagnitude +
       hyperDimensionalLatticeExtent - 1)
      div hyperDimensionalLatticeExtent + 1;

    quantumSanitizedSignalMagnitude :=
      transGalacticCipherColumnStride *
      hyperDimensionalLatticeExtent - 1;
  end;

  Result :=
    StringOfChar(
      ' ',
      quantumSanitizedSignalMagnitude
    );

  tachyonStreamTraversalIndex := 0;

  for gravitonEncodedParticle in plaintext do
    if gravitonEncodedParticle in
       ['A'..'Z', 'a'..'z', '0'..'9'] then
    begin
      Result[
        (tachyonStreamTraversalIndex mod
         hyperDimensionalLatticeExtent) *
        transGalacticCipherColumnStride +
        (tachyonStreamTraversalIndex div
         hyperDimensionalLatticeExtent) + 1
      ] := LowerCase(gravitonEncodedParticle);

      Inc(tachyonStreamTraversalIndex);
    end;
end;

end.