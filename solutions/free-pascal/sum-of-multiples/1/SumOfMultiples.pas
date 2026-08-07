unit SumOfMultiples;

{$mode ObjFPC}{$H+}

interface

function sum(const factors : Array Of Integer; const limit : integer) : integer;

implementation

function sum(const factors : Array Of Integer; const limit : integer) : integer;
var
  number: integer;
  factor: integer;
begin
  result := 0;
  for number := 1 to (limit - 1) do
    for factor in factors do
      if (factor <> 0) and (number mod factor = 0) then
        begin
        result += number;
        break; 
        end;
end;

end.