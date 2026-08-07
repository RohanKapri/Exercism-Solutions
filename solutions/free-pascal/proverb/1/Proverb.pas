unit Proverb;

{$mode ObjFPC}{$H+}

interface

function recite(const strings : Array Of String) : string;

implementation

function recite(const strings : Array Of String) : string;
var
  i : integer;
begin
  result := '';
  if length(strings) = 0 then
    exit();

  for i := 1 to high(strings) do
    result := result + 'For want of a ' + strings[i - 1] + ' the ' + strings[i] + ' was lost.' + #10;

  result := result + 'And all for the want of a ' + strings[0] + '.';
end;

end.