unit uArmstrongNumbers;

interface
// using string conversions
function isArmstrongNumber(ANumber:integer):Boolean;

implementation

uses
  System.Sysutils, System.Math;


function isArmstrongNumber(ANumber:integer):Boolean;
var
  sNumber:String;
  i:integer;
  total:Extended;
begin
  total := 0;
  sNumber := ANumber.ToString;
  for i := Low(sNumber) to High(sNumber) do
    total := Total + Power(StrToFloat(sNumber[i]), Length(sNumber));
  Result := total = ANumber;
end;

end.