unit uProverb;

interface

uses
  System.Generics.Collections, System.Classes;

type
  TStringsArray = TArray<string>;
  TArrayHelper = class helper for TStrings
    function recite:TArray<string>;
  end;

function Proverb(Inputs:TArray<string>):TStrings;

implementation

uses
  System.Sysutils;

function Proverb(Inputs:TArray<string>):TStrings;
const
  LAST_LINE = 'And all for the want of a %s.';
  ALL_LINES = 'For want of a %s the %s was lost.';
var
  i:Integer;
begin
  Result := TStringList.Create;
  if Length(Inputs) = 0 then
    Exit;

  for i := 1 to (Length(Inputs) - 1) do
    Result.Add(Format(ALL_LINES, [Inputs[i-1], Inputs[i]]));
  Result.Add(Format(LAST_LINE,[Inputs[0]]));
end;

{ TArrayHelper }

function TArrayHelper.recite: TArray<string>;
var
  l:TList<String>;
  i:Integer;
begin
  l := TList<string>.Create;
  try
    for i := 0 to (Self.Count - 1) do
      l.Add(Self[i]);
    Result := l.ToArray;
  finally
    FreeAndNil(l);
  end;
end;

end.