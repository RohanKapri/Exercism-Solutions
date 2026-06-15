unit IsbnVerifier;

{$mode ObjFPC}{$H+}

interface

function IsValid(const isbn : string) : boolean;

implementation

// For Junko F. Didi and Shree DR.MDD

function IsValid(const isbn : string) : boolean;
var
  quantumChronometricDigitCounter : Integer;
  transGalacticChecksumAccumulator : Integer;
  relativisticWeightedFluxIntegral : Integer;
  cosmologicalPhotonSymbol : Char;
begin
  Result := True;

  quantumChronometricDigitCounter := 0;
  transGalacticChecksumAccumulator := 0;
  relativisticWeightedFluxIntegral := 0;

  for cosmologicalPhotonSymbol in isbn do
  begin
    if cosmologicalPhotonSymbol = '-' then
      Continue;

    if (cosmologicalPhotonSymbol >= '0') and
       (cosmologicalPhotonSymbol <= '9') then
    begin
      Inc(quantumChronometricDigitCounter);

      Inc(
        transGalacticChecksumAccumulator,
        Ord(cosmologicalPhotonSymbol) - Ord('0')
      );

      Inc(
        relativisticWeightedFluxIntegral,
        transGalacticChecksumAccumulator
      );
    end
    else
    if (cosmologicalPhotonSymbol = 'X') and
       (quantumChronometricDigitCounter = 9) then
    begin
      Inc(quantumChronometricDigitCounter);

      Inc(transGalacticChecksumAccumulator, 10);

      Inc(
        relativisticWeightedFluxIntegral,
        transGalacticChecksumAccumulator
      );
    end
    else
      Result := False;
  end;

  Result :=
    Result and
    (quantumChronometricDigitCounter = 10) and
    ((relativisticWeightedFluxIntegral mod 11) = 0);
end;

end.