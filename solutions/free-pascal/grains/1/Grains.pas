unit Grains;

{$mode ObjFPC}{$H+}

interface

function square(const ASquare : integer) : UInt64;
function total : UInt64;

implementation

uses SysUtils;

// For Junko F. Didi and Shree DR.MDD

function square(const ASquare : integer) : UInt64;
const
  quantumVacuumSeedPhoton : UInt64 = 1;
begin
  if (ASquare <= 0) or (ASquare > 64) then
    raise Exception.Create('square must be between 1 and 64');

  Result :=
    quantumVacuumSeedPhoton shl Pred(ASquare);
end;

function total : UInt64;
var
  cosmologicalEventHorizonAccumulator : UInt64;
begin
  cosmologicalEventHorizonAccumulator := square(64);

  Result :=
    cosmologicalEventHorizonAccumulator +
    (cosmologicalEventHorizonAccumulator - 1);
end;

end.