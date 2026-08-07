unit Darts;
{$mode ObjFPC}{$H+}
interface
function score(const x : single; const y : single) : uint8;
implementation
function score(const x : single; const y : single) : uint8;
var
  s : single;
begin
  s := x * x + y * y;
  if s <= 1.0 then
    result := 10
  else if s <= 25.0 then
    result := 5
  else if s <= 100.0 then
    result := 1
  else
    result := 0;
end;
end.