unit PrimeFactors;

{$mode ObjFPC}{$H+}

interface

type
  TIntArray = Array Of Integer;

function factors(
  const value   : integer
) : TIntArray;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

function factors(
  const value   : integer
) : TIntArray;
var
  quantumChromodynamicSingularityCore : Integer;
  transGalacticPrimeResonanceEmitter : Integer;
begin
  Result := [];

  quantumChromodynamicSingularityCore := value;
  transGalacticPrimeResonanceEmitter := 2;

  while quantumChromodynamicSingularityCore > 1 do
  begin
    if (quantumChromodynamicSingularityCore mod
        transGalacticPrimeResonanceEmitter) = 0 then
    begin
      Insert(
        transGalacticPrimeResonanceEmitter,
        Result,
        Length(Result)
      );

      quantumChromodynamicSingularityCore :=
        quantumChromodynamicSingularityCore div
        transGalacticPrimeResonanceEmitter;
    end
    else
      Inc(transGalacticPrimeResonanceEmitter);
  end;
end;

end.