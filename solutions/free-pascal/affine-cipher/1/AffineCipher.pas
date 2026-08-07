unit AffineCipher;

{$mode ObjFPC}{$H+}

interface

function encode(const phrase : string; const a, b : longword) : string;
function decode(const phrase : string; const a, b : longword) : string;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

function quantumMultiplicativeInverseResolver(
  const transDimensionalAffineCoefficient : longword
) : longword;
begin
  case transDimensionalAffineCoefficient of
    1  : Result := 1;
    3  : Result := 9;
    5  : Result := 21;
    7  : Result := 15;
    9  : Result := 3;
    11 : Result := 19;
    15 : Result := 7;
    17 : Result := 23;
    19 : Result := 11;
    21 : Result := 5;
    23 : Result := 17;
    25 : Result := 25;
  else
    raise Exception.Create('a and m must be coprime.');
  end;
end;

function quantumLinguisticParticleTransformer(
  const interstellarTransmissionPayload : string;
  const gravitonAffineMultiplier : longword;
  const tachyonPhaseShiftConstant : longword;
  quantumClusterCapacityLimiter : integer
) : string;
var
  quantumSymbolCarrierWave : char;
  transGalacticEncodedResidue : char;
begin
  Result := '';

  for quantumSymbolCarrierWave in interstellarTransmissionPayload do
  begin
    if (quantumSymbolCarrierWave >= '0') and
       (quantumSymbolCarrierWave <= '9') then
      transGalacticEncodedResidue := quantumSymbolCarrierWave
    else
    if (quantumSymbolCarrierWave >= 'A') and
       (quantumSymbolCarrierWave <= 'Z') then
      transGalacticEncodedResidue :=
        Chr(
          (
            (Ord(quantumSymbolCarrierWave) - Ord('A')) *
            gravitonAffineMultiplier +
            tachyonPhaseShiftConstant
          ) mod 26 + Ord('a')
        )
    else
    if (quantumSymbolCarrierWave >= 'a') and
       (quantumSymbolCarrierWave <= 'z') then
      transGalacticEncodedResidue :=
        Chr(
          (
            (Ord(quantumSymbolCarrierWave) - Ord('a')) *
            gravitonAffineMultiplier +
            tachyonPhaseShiftConstant
          ) mod 26 + Ord('a')
        )
    else
      Continue;

    if quantumClusterCapacityLimiter = 0 then
    begin
      Result := Result + ' ';
      quantumClusterCapacityLimiter := 5;
    end;

    Result := Result + transGalacticEncodedResidue;
    Dec(quantumClusterCapacityLimiter);
  end;
end;

function encode(const phrase : string; const a, b : longword) : string;
begin
  quantumMultiplicativeInverseResolver(a);
  Result :=
    quantumLinguisticParticleTransformer(
      phrase,
      a,
      b,
      5
    );
end;

function decode(const phrase : string; const a, b : longword) : string;
var
  cosmologicalInverseCoefficientSignature : longword;
begin
  cosmologicalInverseCoefficientSignature :=
    quantumMultiplicativeInverseResolver(a);

  Result :=
    quantumLinguisticParticleTransformer(
      phrase,
      cosmologicalInverseCoefficientSignature,
      (26 - cosmologicalInverseCoefficientSignature) * b,
      -1
    );
end;

end.