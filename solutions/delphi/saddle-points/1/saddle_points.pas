unit uSaddlePoints;

interface

uses uSaddlePointsTests;

type
  ISaddlePoints = Interface
    function Calculate: TArray<TTuple<integer, integer>>;
  End;

  TSaddlePoints = class(TInterfacedObject, ISaddlePoints)
  private
    FValues: TArray<TArray<integer>>;
    FWidth: integer;
    FHeight: integer;
    function GetCols(id: integer): TArray<integer>;
    function GetRows(id: integer): TArray<integer>;
  protected
    function IsSaddle(col, row: integer): Boolean;
    property Width: integer read FWidth write FWidth;
    property Height: integer read FHeight write FHeight;
  public
    constructor Create(values: TArray < TArray < integer >> );
    function Calculate: TArray<TTuple<integer, integer>>;
    property Cols[id: integer]: TArray<integer> read GetCols;
    property Rows[id: integer]: TArray<integer> read GetRows;
  end;

function newSaddlePoints(values: TArray < TArray < integer >> ): ISaddlePoints;

implementation

uses System.Math, System.Generics.Collections;

function newSaddlePoints(values: TArray < TArray < integer >> ): ISaddlePoints;
begin
  result := TSaddlePoints.Create(values);
end;

{ TSaddlePoints }

function TSaddlePoints.Calculate: TArray<TTuple<integer, integer>>;
begin
  result := [];
  for var i := 0 to FWidth - 1 do
    for var j := 0 to FHeight - 1 do
      if IsSaddle(i, j) then
        result := result + [TTuple<integer, integer>.Create(j + 1, i + 1)];
end;

constructor TSaddlePoints.Create(values: TArray < TArray < integer >> );
begin
  inherited Create;
  FValues := values;
  FHeight := Length(values);
  if FHeight > 0 then
    FWidth := Length(values[0])
  else
    FWidth := 0;
end;

function TSaddlePoints.GetCols(id: integer): TArray<integer>;
begin
  result := FValues[id];
end;

function TSaddlePoints.GetRows(id: integer): TArray<integer>;
begin
  result := [];
  for var val in FValues do
    result := result + [val[id]];
end;

function TSaddlePoints.IsSaddle(col, row: integer): Boolean;
var
  tmp: TArray<integer>;
begin
  result := false;
  tmp := Cols[row];
  if MaxIntValue(tmp) = tmp[col] then
  begin
    tmp := Rows[col];
    if MinIntValue(tmp) = tmp[row] then
      result := true;
  end;
end;

end.