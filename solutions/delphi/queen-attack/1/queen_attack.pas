unit uQueenAttack;

interface

type
  TQueen = class
  private
    x,y:integer;
  public
    function CanAttack(aQuenn:TQueen):boolean;
    constructor Create(const aRow, aCol:integer);
  end;

implementation

uses
  System.SysUtils;

{ TQueen }

function TQueen.CanAttack(aQuenn: TQueen): boolean;
begin
  Result := (x = aQuenn.x) or (y = aQuenn.y) or           // same row,col
            ((x + y) = (aQuenn.x + aQuenn.y)) or          // first + second diagonal
            (Abs(x - y) = Abs(aQuenn.x - aQuenn.y));      // third + four diagonal
end;

constructor TQueen.Create(const aRow, aCol: integer);
begin
  inherited Create;

  if aRow < 0 then
    raise EArgumentException.Create('row not positive');
  if acol < 0 then
    raise EArgumentException.Create('column not positive');
  if (acol > 7)  then
    raise EArgumentException.Create('column not on board');
  if (aRow > 7) then
    raise EArgumentException.Create('row not on board');

  x := aRow;
  y := aCol;
end;

end.