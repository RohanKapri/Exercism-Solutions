unit Acronym;

{$mode ObjFPC}{$H+}

interface

function abbreviate(const phrase: string) : string;

implementation

function abbreviate(const phrase: string) : string;
var
  skipping: boolean;
  c : char;
  letter : char;
begin
  result := '';
  skipping := false;
  for c in phrase do
    begin
    letter := chr(ord(c) and 223);
    if (letter < 'A') or (letter > 'Z') then
      skipping := skipping and (c = #39)
    else if (not skipping) then
      begin
        result := result + letter;
        skipping := true;
      end;
    end;
end;

end.