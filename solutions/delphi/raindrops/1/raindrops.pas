unit uRaindrops;

interface

type
  Raindrops = class
  const
    FACTOR_3 = 'Pling';
    FACTOR_5 = 'Plang';
    FACTOR_7 = 'Plong';
  private
    class function IsFactor(const AValue, AFactor:integer):Boolean;
  public
    class function Convert(const AValue:integer):string;
  end;

implementation

uses
  System.SysUtils;

{ Raindrops }

class function Raindrops.Convert(const AValue: integer): string;
begin
  Result := string.Empty;
  if IsFactor(AValue, 3) then
    Result := Result + FACTOR_3;
  if IsFactor(AValue, 5) then
    Result := Result + FACTOR_5;
  if IsFactor(AValue, 7) then
    Result := Result + FACTOR_7;
  // The rest of cases, the result is the number
  if (Result = string.Empty) then
    Result := IntToStr(AValue);
end;

class function Raindrops.IsFactor(const AValue, AFactor: integer): Boolean;
begin
  Result := (AValue mod AFactor = 0);
end;

end.
