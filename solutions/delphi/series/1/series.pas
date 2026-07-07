unit uSeries;

interface

type
  TSlice = class
  private
    FStringOfDigits:string;
  public
    /// <summary> Initial string </summary>
    property StringOfDigits:string read FStringOfDigits;
    /// <summary> constructor of the class </summary>
    constructor Create(AValue: string);
    /// <summary> extract substrings </summary>
    function slices(const ALength:integer):TArray<string>;
  end;

implementation

uses
  System.Sysutils, System.Generics.Collections;

{ TSlice }

constructor TSlice.Create(AValue: string);
begin
  inherited Create;
  FStringOfDigits := AValue;
end;

function TSlice.slices(const ALength: integer): TArray<string>;
var
  i:Integer;
  l:TList<string>;
begin
  if (FStringOfDigits = string.Empty) then
    raise EArgumentException.Create('series cannot be empty');
  if (ALength < 0) then
    raise EArgumentOutOfRangeException.Create('slice length cannot be negative');
  if (ALength = 0) then
    raise EArgumentOutOfRangeException.Create('slice length cannot be zero');
  if ALength > Length(FStringOfDigits) then
    raise EArgumentOutOfRangeException.Create('slice length cannot be greater than series length');

  l := Tlist<string>.Create;
  for i := 1 to (Length(FStringOfDigits) - ALength + 1) do
    l.Add(Copy(FStringOfDigits, i, ALength));
  Result := l.ToArray;
  l.Free;
end;

end.