unit uSecretHandshake;

interface

type
  TSecretHandShake = class
    class function commands(code: integer): TArray<string>;
  end;

implementation

uses System.Generics.Collections;

{ TSecretHandShake }

class function TSecretHandShake.commands(code: integer): TArray<string>;
var
  table: TDictionary<string, Byte>;
begin
  result := [];
  table := TDictionary<string, Byte>.Create;
  try
    table.Add('wink', 1);
    table.Add('double blink', 1 shl 1);
    table.Add('close your eyes', 1 shl 2);
    table.Add('jump', 1 shl 3);
    for var item in table do
      if item.Value and code > 0 then
        if code shr 4 = 1 then
          result := result + [item.Key]
        else
          result := [item.Key] + result;
  finally
    table.Free;
  end;
end;

end.