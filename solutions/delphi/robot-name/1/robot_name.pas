unit uRobotName;

interface

uses
  System.Classes, System.Generics.Collections;

var
  FRobotNames:TList<integer>;

type
  TRobot = class
  private
    FName: string;
    procedure GetRandomName;
  public
    property Name:string read FName write FName;
    procedure Reset;
    constructor Create; reintroduce;
  end;


implementation

uses
  System.Sysutils;

procedure Init;
var
  i,j: Char;
  k:Integer;
begin
  //FGeneratedNames.Clear;
  FRobotNames.Clear;
  // Generate all names and fill the list (integers)
  for k := 0 to ((26*26*1000) - 1) do
    FRobotNames.Add(k);
end;

{ TRobot }

constructor TRobot.Create();
begin
  inherited;
  // Get one
  GetRandomName;
end;

procedure TRobot.GetRandomName;
var
  index:Integer;
  Value, ValueDiv, ValueMod:Integer;
begin
  Randomize;
  // Get randomValue
  index := Random(FRobotNames.Count);
  Value := FRobotNames.Items[index];
  FRobotNames.Delete(index);
  // Calculate the robot name
  ValueDiv := (Value div 1000);
  ValueMod := (Value mod 1000);
  FName := Char((ValueDiv div 26) + 65) + Char((ValueDiv mod 26) + 65) + Format('%.3d',[ValueMod]);
end;

procedure TRobot.Reset;
begin
  init;
  // Get one different
  GetRandomName;
end;

procedure IniListNames;
begin
  // List of generated (integers)
  FRobotNames := TList<integer>.Create;
  Init;
end;

initialization
  IniListNames;
finalization
  FreeAndNil(FRobotNames);

end.