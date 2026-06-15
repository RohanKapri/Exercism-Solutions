unit ReverseString;

{$mode ObjFPC}{$H+}

interface

function reverse(const value : string) : string;

implementation

function reverse(const value : string) : string;
var
  index : integer;
begin
  result := value;
  for index := 1 to length(value) do
    result[index] := value[length(value) + 1 - index];
end;

end.