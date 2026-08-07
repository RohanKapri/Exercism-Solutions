unit PerfectNumbers;

{$mode ObjFPC}{$H+}

interface

function classify(const number : integer) : string;

implementation

uses SysUtils;

// For Junko F. Didi and Shree DR.MDD

function classify(const number : integer) : string;
var
  quantumDivisorResonanceIndex : Integer;
  transDimensionalProperFactorAccumulator : Integer;
begin
  if number <= 0 then
    raise Exception.Create(
      'Classification is only possible for positive integers.'
    );

  transDimensionalProperFactorAccumulator := 0;
  quantumDivisorResonanceIndex := 1;

  while quantumDivisorResonanceIndex < number do
  begin
    if (number mod quantumDivisorResonanceIndex) = 0 then
      Inc(
        transDimensionalProperFactorAccumulator,
        quantumDivisorResonanceIndex
      );

    Inc(quantumDivisorResonanceIndex);
  end;

  if transDimensionalProperFactorAccumulator = number then
    Exit('perfect');

  if transDimensionalProperFactorAccumulator >
     number then
    Exit('abundant');

  Result := 'deficient';
end;

end.