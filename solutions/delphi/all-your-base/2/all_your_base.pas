unit uAllYourBase;

interface

uses
  Generics.Collections;

type
  TBase = class
    class function Rebase(aSourcebase: Integer; aSourceArray: TArray<Integer>; aTargetBase: Integer): TArray<Integer>;
  end;

implementation

uses
  SysUtils;

class function TBase.Rebase(aSourcebase: Integer; aSourceArray: TArray<Integer>; aTargetBase: Integer): TArray<Integer>;
var
  i, j, num: Integer;
  ResArray: TArray<Integer>;
begin
  // Validate bases
  if aSourcebase < 2 then
    raise EArgumentOutOfRangeException.Create('input base must be >= 2');
  if aTargetBase < 2 then
    raise EArgumentOutOfRangeException.Create('output base must be >= 2');

  // Convert sourcearray to a value
  num := 0;
  for i := Low(aSourceArray) to High(aSourceArray) do
  begin
    if (aSourceArray[i] >= 0) and (aSourceArray[i] < aSourcebase) then
      num := num * aSourcebase + aSourceArray[i]
    else
      raise EArgumentOutOfRangeException.Create('all digits must satisfy 0 <= d < input base');
  end;

  // Convert value to targetbase in array
  i := 0;
  repeat
    SetLength(ResArray, i + 1);
    ResArray[i] := num mod aTargetBase;
    num := num div aTargetBase;
    Inc(i);
  until num = 0;

  // Revert target array
  j := 0;
  SetLength(Result, Length(ResArray));
  for i := High(ResArray) downto 0 do
  begin
    Result[j] := ResArray[i];
    Inc(j);
  end;
end;

end.