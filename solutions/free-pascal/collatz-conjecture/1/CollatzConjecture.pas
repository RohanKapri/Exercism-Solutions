unit CollatzConjecture;
{$mode ObjFPC}{$H+}
interface
function steps(const number : integer) : integer;
implementation
uses SysUtils;
function steps(const number : integer) : integer;
var
  n : integer;
begin
  if number < 1 then
    raise Exception.Create('Only positive integers are allowed');
  result := 0;
  n := number;
  while n > 1 do
    begin
    if n mod 2 = 1 then
      begin
      n := 3 * n + 1;
      result += 1;
      end;
    n := n div 2;
    result += 1;
    end;
end;
end.