unit SquareRoot;

{$mode ObjFPC}{$H+}

interface

function SquareRoot(const radicand : integer) : integer;

implementation

function SquareRoot(const radicand : integer) : integer;
begin
  result := 0;
  repeat
    result := result + 1;
  until result * result >= radicand;
end;

end.