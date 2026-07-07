unit uDarts;

interface

type
  TDarts = class
    class function Score(const x,y:extended):Integer;
  end;

implementation

uses
  System.Sysutils, System.Math;

{ TDarts }

class function TDarts.Score(const x, y: extended): Integer;
var
  h:Extended;
begin
  Result := 0;
  h := sqrt(Power(x, 2) + Power(y, 2));
  if (h <= 10) then
    Result := 1;
  if (h <= 5) then
    Result := 5;
  if (h <= 1) then
    Result := 10;
end;

end.