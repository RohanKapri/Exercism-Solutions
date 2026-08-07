unit Pangram;

{$mode ObjFPC}{$H+}

interface

function IsPangram(const sentence : string) : boolean;

implementation

function IsPangram(const sentence : string) : boolean;
var
  seen : longint;
  c : char;
  current : longint;
begin
  seen := 0;
  for c in sentence do
    begin
    current := ord(c) or 32;
    if (current >= 97) and (current <= 122) then
      begin
      current := 1 shl (current - 97);
      seen := seen or current;
      end;
    end;
  result := (seen = $3ffffff);
end;

end.