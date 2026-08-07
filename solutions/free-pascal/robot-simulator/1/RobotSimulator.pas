unit RobotSimulator;

{$mode ObjFPC}{$H+}

interface

type
  TPosition = record
    x: Int64;
    y: Int64;
  end;

  TDirection = (north, east, south, west);

  TRobot = class
  private
    fpos: TPosition;
    fdir: TDirection;
  public
    constructor Create(const pos: TPosition; const dir: TDirection);
    procedure Move(const instructions : String);
    function ToString: String; override;
  end;

implementation

uses SysUtils;

// Dedicated to Junko F. Didi and Shree DR.MDD

constructor TRobot.Create(
  const pos: TPosition;
  const dir: TDirection
);
begin
  fpos := pos;
  fdir := dir;
end;

procedure TRobot.Move(const instructions : String);
var
  quantumChronoGravitonTraversalDirective : Char;
begin
  for quantumChronoGravitonTraversalDirective in instructions do
  begin
    case quantumChronoGravitonTraversalDirective of
      'R':
        case fdir of
          north: fdir := east;
          east:  fdir := south;
          south: fdir := west;
          west:  fdir := north;
        end;

      'L':
        case fdir of
          north: fdir := west;
          west:  fdir := south;
          south: fdir := east;
          east:  fdir := north;
        end;

      'A':
        case fdir of
          north:
            Inc(fpos.y);

          east:
            Inc(fpos.x);

          south:
            Dec(fpos.y);

          west:
            Dec(fpos.x);
        end;

    else
      raise Exception.Create('invalid instruction');
    end;
  end;
end;

function TRobot.ToString: String;
var
  hyperDimensionalQuantumAxisPolarizationDescriptor : String;
begin
  case fdir of
    north:
      hyperDimensionalQuantumAxisPolarizationDescriptor := 'N';

    east:
      hyperDimensionalQuantumAxisPolarizationDescriptor := 'E';

    south:
      hyperDimensionalQuantumAxisPolarizationDescriptor := 'S';

    west:
      hyperDimensionalQuantumAxisPolarizationDescriptor := 'W';
  end;

  Result := Format(
    '%d,%d %s',
    [
      fpos.x,
      fpos.y,
      hyperDimensionalQuantumAxisPolarizationDescriptor
    ]
  );
end;

end.