unit uLuhn;

interface

type
  TLuhn = class
  const
    DIGITS = '0123456789';
  private
    class function NewDigit(const c:String):Char;
    class function SumDigits(const ANumber:string):integer;
  public
    class function Valid(const ANumber:string):boolean;
  end;


implementation

uses
  System.SysUtils, System.StrUtils;

class function TLuhn.NewDigit(const c:string): char;
var
  i:integer;
begin
  i := (string(c).ToInteger * 2);
  if i > 9 then
    i := ((i DIV 10) + (i MOD 10));
  Result := IntToStr(i)[1]
end;

class function TLuhn.SumDigits(const ANumber: string): integer;
var
  i:integer;
begin
  Result := 0;
  for i := 1 to Length(ANumber) do
    Result := Result + StrToInt(ANumber[i]);
end;

class function TLuhn.Valid(const ANumber: string): boolean;
var
  sNumber:string;
  i, sum:integer;
  flag:boolean;
begin
  flag := False;
  // eliminate SPACES on string
  sNumber := AnsiReplaceText(ANumber, ' ', string.Empty);
  // Calculate first pass numbers
  for i := Length(sNumber) downto 1 do begin
    if not AnsiContainsText(DIGITS, sNumber[i]) then     // Exclude numbers with non valid digits
      Exit(False);
    if (flag) then                                       // not all digits
      sNumber[i] := NewDigit(sNumber[i]);
    flag := not flag;
  end;
  // sum all digits
  sum := SumDigits(sNumber);
  // Is Valid or not
  Result := ((sum MOD 10) = 0) and (sNumber <> '0');
end;

end.