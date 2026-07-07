unit uDifferenceOfSquares;

interface

function squareOfSum(AInp : integer) : integer;

function sumOfSquares(AInp : integer) : integer;

function differenceOfSquares(AInp : integer) : integer;

implementation

function squareOfSum(AInp : integer) : integer;
var
  I: Integer;
begin
  Result :=1;
  for I := 2 to AInp do
    Result := Result + i;
  Result := sqr(Result);
end;

function sumOfSquares(AInp : integer) : integer;
var
  I: Integer;
begin
  Result := 1;
  for I := 2 to AInp do
    Result := Result + sqr(i);
end;

function differenceOfSquares(AInp : integer) : integer;
begin
  Result := squareOfSum(AInp) - sumOfSquares(AInp);
end;

end.