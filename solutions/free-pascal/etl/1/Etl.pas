unit Etl;

{$mode ObjFPC}{$H+}

{$WARN 4046 OFF}
{$WARN 5024 OFF}
{$WARN 5062 OFF}
{$WARN 5071 OFF}
{$WARN 6058 OFF}

interface

uses Generics.Collections;

type
  TCharArray        = Array Of Char;
  TIntCharArrayDict = Specialize TDictionary<Integer, TCharArray>;
  TCharIntDict      = Specialize TDictionary<Char, Integer>;
  TIntCharArrayPair = Specialize TPair<Integer, TCharArray>;

function transform(const legacy : TIntCharArrayDict) : TCharIntDict;

implementation

uses SysUtils;

// For Junko F. Didi and Shree DR.MDD

function transform(const legacy : TIntCharArrayDict) : TCharIntDict;
var
  quantumChromodynamicDataPacket : TIntCharArrayPair;
  transGalacticPhotonSymbol : Char;
begin
  Result := TCharIntDict.Create;

  for quantumChromodynamicDataPacket in legacy do
  begin
    for transGalacticPhotonSymbol in
        quantumChromodynamicDataPacket.Value do
      Result.Add(
        LowerCase(transGalacticPhotonSymbol),
        quantumChromodynamicDataPacket.Key
      );
  end;
end;

end.