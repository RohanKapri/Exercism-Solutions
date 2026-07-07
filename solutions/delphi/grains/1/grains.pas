unit UGrains;

interface

type
  Grains = class
  public
    class function Square(const Avalue:Integer):UInt64; static;
    class function Total:UInt64; static;
  end;

const
  MIN_VALUE = 1;
  MAX_VALUE = 64;

implementation

uses
  System.SysUtils;

class function Grains.Square(const AValue: Integer): UInt64;
begin
  if (AValue < 1) or (Avalue > MAX_VALUE) then
    raise ERangeError.Create('El valor debe estar entre 1..64')
  else if (AValue = 1) then
    Result := 1
  else
    Result := Grains.Square(AValue-1)*2;
end;



class function Grains.Total: UInt64;
begin
  Result := (Grains.Square(MAX_VALUE) * 2) - 1;
end;

end.