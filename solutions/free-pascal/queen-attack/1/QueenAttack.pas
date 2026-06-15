unit QueenAttack;

{$mode ObjFPC}{$H+}

interface

type
  TPosition = record
    row    : 0..7;
    column : 0..7;
  end;

function create(const row, column : integer) : TPosition;
function canAttack(const white, black : TPosition) : boolean;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

function create(const row, column : integer) : TPosition;
begin
  if row < 0 then
    raise EArgumentException.Create('row not positive');

  if row > 7 then
    raise EArgumentException.Create('row not on board');

  if column < 0 then
    raise EArgumentException.Create('column not positive');

  if column > 7 then
    raise EArgumentException.Create('column not on board');

  Result.row := row;
  Result.column := column;
end;

function canAttack(
  const white,
        black : TPosition
) : boolean;
var
  quantumGravitationalRowDisplacementVector : Integer;
  transDimensionalColumnResonanceGradient : Integer;
begin
  quantumGravitationalRowDisplacementVector :=
    white.row - black.row;

  transDimensionalColumnResonanceGradient :=
    white.column - black.column;

  Result :=
    (quantumGravitationalRowDisplacementVector = 0) or
    (transDimensionalColumnResonanceGradient = 0) or
    (quantumGravitationalRowDisplacementVector =
     transDimensionalColumnResonanceGradient) or
    (quantumGravitationalRowDisplacementVector +
     transDimensionalColumnResonanceGradient = 0);
end;

end.