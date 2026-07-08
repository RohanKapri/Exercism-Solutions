unit uNthPrime;

interface

type
  TPrime = class
    // Calculate the N-prime number
    class function CalculatePrimeN(aNumber: integer):integer;
    // Is a prime number?
    class function EsPrime(aNumber:integer):boolean;
  end;



function NthPrime(aNumber:integer):integer;

implementation

uses
  System.SysUtils;

function NthPrime(aNumber:integer):integer;
begin
  if (aNumber = 0) then
    raise EArgumentOutOfRangeException.Create('there is no zeroth prime');
  Result := TPrime.CalculatePrimeN(aNumber);
end;

{ TPrime }

class function TPrime.CalculatePrimeN(aNumber: integer):integer;
var
  iCount, actualNumber:integer;
begin
  // ini
  iCount := 0;
  actualNumber := 1;
  Result := 0;
  // Calculate the N Prime
  while (iCount < aNumber) do begin
    if TPrime.EsPrime(actualNumber) then begin
      Result := actualNumber;
      Inc(iCount);
    end;
    // This is the n-prime number
    if (aNumber = iCount) then
      Break;
    Inc(actualNumber);
  end;
end;

class function TPrime.EsPrime(aNumber: integer): boolean;
begin
  var count:integer := 0;
  for var i:integer := 1 to aNumber do begin
    if ((aNumber MOD i) = 0) then
      Inc(count);
    // optimization (for calculate if the number is prime)
    if (count > 2) then
      Break;
  end;
  Result := (count = 2);
end;

end.