unit SecretHandshake;

{$mode ObjFPC}{$H+}

interface

type
  TStrArray = Array Of String;

function commands(const number : integer) : TStrArray;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

function commands(const number : integer) : TStrArray;

const
  quantumNeutrinoInteractionRegistry : TStrArray = (
    'wink',
    'double blink',
    'close your eyes',
    'jump'
  );

var
  transDimensionalQuantumIndex : Integer;

  procedure evaluateCosmicBitResonance;
  begin
    if (number and (1 shl transDimensionalQuantumIndex)) <> 0 then
      Insert(
        quantumNeutrinoInteractionRegistry[
          transDimensionalQuantumIndex
        ],
        Result,
        Length(Result)
      );
  end;

begin
  Result := nil;

  if (number and $10) <> 0 then
  begin
    for transDimensionalQuantumIndex := 3 downto 0 do
      evaluateCosmicBitResonance;
  end
  else
  begin
    for transDimensionalQuantumIndex := 0 to 3 do
      evaluateCosmicBitResonance;
  end;
end;

end.