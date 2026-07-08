unit uPalindromeProducts;

interface

uses
  SysUtils;

type
  TPalindromeResult = TArray<TArray<TArray<Integer>>>;

  TPalindromeProduct = class
    class function Largest(RangeStart, RangeEnd: Integer): TPalindromeResult;
    class function Smallest(RangeStart, RangeEnd: Integer): TPalindromeResult;
  end;

implementation

uses
  StrUtils, Generics.Collections;

type
  TGoalFunc = function(Int, GoalInt: Integer): Boolean;

function Max(Int, GoalInt: Integer): Boolean;
begin
  Result := Int > GoalInt;
end;
function Min(Int, GoalInt: Integer): Boolean;
begin
  Result := Int < GoalInt;
end;

function PalindromeProduct(
  RangeStart, RangeEnd: Integer;
  GoalFunc: TGoalFunc; InitialGoal: Integer): TPalindromeResult;

  procedure ValidateRange(RangeStart, RangeEnd: Integer);
  begin
    if RangeStart > RangeEnd then
      raise EArgumentException.Create('min must be <= max');
  end;

  function IsPalindrome(Int: Integer): Boolean;
  begin
    Result := Int.ToString = ReverseString(Int.ToString);
  end;

var
  i, j, Product: Integer;
begin
  ValidateRange(RangeStart, RangeEnd);

  for i := RangeEnd downto RangeStart do begin
    for j := i downto RangeStart do begin
      Product := i * j;
      if IsPalindrome(Product) then
        if GoalFunc(Product, InitialGoal) then begin
          InitialGoal := Product;
          Result := [[[Product]], [[j, i]]];
        end else if (Product = InitialGoal) then begin
          Result := [[[Product]], Result[1] + [[j, i]]];
        end;
    end;
  end;
end;

{ TPalindromeProduct }

class function TPalindromeProduct.Largest(
  RangeStart, RangeEnd: Integer): TPalindromeResult;
begin
  Result := PalindromeProduct(RangeStart, RangeEnd, Max, 0);
end;

class function TPalindromeProduct.Smallest(
  RangeStart, RangeEnd: Integer): TPalindromeResult;
begin
  Result := PalindromeProduct(RangeStart, RangeEnd, Min, MaxInt);
end;

end.