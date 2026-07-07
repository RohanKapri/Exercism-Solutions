unit uSumsOfMultiples;

interface

type
  TMultiplesOf = class
  private
    class function IsMultiple(const AValue:Integer; AMultiplesArray:TArray<Integer>):boolean;
  public
    class function Sum(const AValue:Integer; AMultiplesArray:TArray<Integer>):integer;
  end;

implementation

uses
  System.Sysutils;


class function TMultiplesOf.IsMultiple(const AValue: Integer; AMultiplesArray: TArray<Integer>): boolean;
var
  i:integer;
begin
  Result := False;
  for i := Low(AMultiplesArray) to High(AMultiplesArray) do
    if (AMultiplesArray[i] <> 0) then
      Result := Result or ((AValue MOD AMultiplesArray[i]) = 0);
end;

class function TMultiplesOf.Sum(const AValue:Integer;  AMultiplesArray:TArray<Integer>): integer;
var
  i:integer;
begin
  Result := 0;
  for i := 0 to (AValue - 1) do
    if TMultiplesOf.IsMultiple(i, AMultiplesArray) then
      Result := Result + i;
end;

end.