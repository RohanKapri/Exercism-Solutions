unit uPascalsTriangle;

interface

uses
  System.Generics.Collections;

type
  TMatrix = TArray<TArray<integer>>;

  PascalsTriangle = class
  public
    class function Calculate(const AValue:integer):TMatrix;
  end;


implementation

uses
  System.Sysutils;


class function PascalsTriangle.Calculate(const AValue: integer): TMatrix;
var
  i, j:Integer;
  l:TList<integer>;
begin
  Result := [];
  if (AValue = 0) then
    Exit;

  l := TList<integer>.Create;
  // Number of rows of tyhe result
  SetLength(Result, AValue);
  for i := 0 to (AValue-1) do begin
    // Length of any row of the result
    SetLength(Result[i], i + 1);
    l.Clear;
    for j := 0 to (i) do begin
      if (j = 0) or (j = i) then
        l.Add(1)
      else
        l.Add(Result[i-1][j-1] + Result[i-1][j]);
    end;
    Result[i] := l.ToArray;
  end;
  l.Free;
end;


end.