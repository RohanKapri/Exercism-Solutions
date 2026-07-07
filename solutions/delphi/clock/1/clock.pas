unit uClock;

interface

uses
  System.SysUtils;

type
  Clock = Record
  const
    TOTAL_MINUTES_ON_DAY = 60*24;
  public
    TotalMinutes:Integer;

    /// <summary> Correct value to compare, show,... </summary>
    procedure Correct;
    /// <summary> Get hour on clock </summary>
    function Horas:Integer;
    /// <summary> Get minutes on clock </summary>
    function Minutos:Integer;

    constructor SetHands(AHoras:integer; aMinutos:integer=0);
    function Add(AMinutos:integer):Clock;
    function Subtract(AMinutos:integer): Clock;
    function Equal(AClock:Clock): Boolean;
    function ToString: string; overload; inline;
  End;

implementation

constructor Clock.SetHands(AHoras: integer; AMinutos:integer=0);
begin
  TotalMinutes := ((AHoras * 60) + aMinutos) mod TOTAL_MINUTES_ON_DAY;
end;

function Clock.Add(AMinutos: Integer): Clock;
begin
  TotalMinutes := TotalMinutes + (AMinutos mod TOTAL_MINUTES_ON_DAY);
  Result := Self;
end;

function Clock.Subtract(AMinutos: Integer): Clock;
begin
  TotalMinutes := TotalMinutes - (AMinutos mod TOTAL_MINUTES_ON_DAY);
  Result := Self;
end;

function Clock.ToString: string;
begin
  Result := Format('%.2d:%.2d',[Horas, Minutos]);
end;

procedure Clock.Correct;
begin
  // Correct negative values
  if TotalMinutes < 0 then TotalMinutes := TOTAL_MINUTES_ON_DAY + TotalMinutes;
  // Correct big values
  TotalMinutes := TotalMinutes mod TOTAL_MINUTES_ON_DAY;
end;

function Clock.Equal(aClock: Clock): Boolean;
begin
  Result := (Self.Horas = aClock.Horas) and (Self.Minutos = aClock.Minutos);
end;

function Clock.Horas: Integer;
begin
  Correct;
  Result := TotalMinutes div 60;
end;

function Clock.Minutos: Integer;
begin
  Correct;
  Result := TotalMinutes mod 60;
end;

end.