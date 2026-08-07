unit ScrabbleScore;
{$mode ObjFPC}{$H+}
interface
function score(const word : string) : integer;
implementation
function points(const c : char) : integer;
begin
  result := 0;
  if (c = 'a') or (c = 'e') or (c = 'i') or (c = 'o') or (c = 'u') or (c = 'l') or (c = 'n') or (c = 'r') or (c = 's') or (c = 't') then result := 1;
  if (c = 'd') or (c = 'g') then result := 2;
  if (c = 'b') or (c = 'c') or (c = 'm') or (c = 'p') then result := 3;
  if (c = 'f') or (c = 'h') or (c = 'v') or (c = 'w') or (c = 'y') then result := 4;
  if (c = 'k') then result := 5;
  if (c = 'j') or (c = 'x') then result := 8;
  if (c = 'q') or (c = 'z') then result := 10;
end;
function score(const word : string) : integer;
var
  c : char;
begin
  result := 0;
  for c in word do
    result += points(chr(ord(c) or 32));
end;
end.