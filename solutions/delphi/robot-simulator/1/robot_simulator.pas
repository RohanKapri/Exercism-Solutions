unit uRobotSimulator;

interface

uses
  System.Types, System.StrUtils;

type
  TDirection = (north, east, south, west);

  TCoordinate = record
    x:integer;
    y:integer;
    constructor Create(const aX, aY:integer);
  end;

  TRobotSimulator = class
  private
    FCoordinate: TCoordinate;
    FDirection: TDirection;

    procedure TurnLeft;
    procedure TurnRight;
    procedure Advance;
  public
    constructor Create(aDirection:TDirection; aCoordinate:TCoordinate);
    procedure Move(const aMovement:string);
    destructor Destroy; override;

    property Coordinate:TCoordinate read FCoordinate;
    property Direction:TDirection read FDirection;
  end;

implementation

uses
  System.SysUtils;

constructor TCoordinate.Create(const aX, aY:integer);
begin
  x := aX;
  y := aY;
end;

{ TRobotSimulator }

constructor TRobotSimulator.Create(aDirection: TDirection; aCoordinate: TCoordinate);
begin
  inherited Create;
  FCoordinate := TCoordinate.Create(aCoordinate.x, aCoordinate.y);
  FDirection := aDirection;
end;

destructor TRobotSimulator.Destroy;
begin
  inherited;
end;

procedure TRobotSimulator.Move(const aMovement: string);
var
  ch:char;
begin
  for ch in aMovement do
    case AnsiIndexStr(ch, ['L', 'R', 'A']) of
      0: TurnLeft;
      1: TurnRight;
      2: Advance;
    end;
end;

procedure TRobotSimulator.TurnLeft;
begin
  //   TDirection = (north, east, south, west);
  if (FDirection = north) then
    FDirection := west
  else
    FDirection := TDirection( (Ord(FDirection) - 1) MOD 4);
end;

procedure TRobotSimulator.TurnRight;
begin
  //   TDirection = (north, east, south, west);
  if (FDirection = west) then
    FDirection := north
  else
    FDirection := TDirection( (Ord(FDirection) + 1) MOD 4);
end;

procedure TRobotSimulator.Advance;
begin
  case FDirection of
    north: Inc(FCoordinate.y);
    east:  Inc(FCoordinate.x);
    south: Dec(FCoordinate.y);
    west:  Dec(FCoordinate.x);
  end;
end;

end.