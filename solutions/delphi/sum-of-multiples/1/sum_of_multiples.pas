unit uSumOfMultiples;

interface

type
  TMultiplesOf = class
    class function Sum(digit: integer; const members: array of integer)
      : integer;
  end;

implementation

uses System.Math, System.Generics.Collections;

{ TMultiples }

class function TMultiplesOf.Sum(digit: integer;
  const members: array of integer): integer;
begin
  result := 0;
  for var i := 1 to digit - 1 do
    for var id in members do
      if (id > 0) and (i mod id = 0) then
      begin
        inc(result, i);
        break;
      end;
end;

end.