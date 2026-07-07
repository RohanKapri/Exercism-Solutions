unit uCollatzconjecture;

interface

uses
  System.Sysutils;

type
  EIllegalNumber = class(Exception);

function collatzSteps(AValue:integer):Integer;

implementation

// SOLUTION: Recursive call
function collatzSteps(AValue:integer):Integer;
begin
  // Numbers <= 0 not allowed
  if (AValue <= 0) then
    raise EIllegalNumber.Create('error: Only positive numbers are allowed');

  // for 1 => 0 steps
  if (AValue = 1) then begin
    Result := 0;
    Exit;
  end;

  // Others numbers (use recursive call) and increment the number of steps returned
  if Odd(AValue) then
    Result := collatzSteps((Avalue * 3) + 1) + 1
  else
    Result := collatzSteps(AValue div 2) + 1;
end;

end.