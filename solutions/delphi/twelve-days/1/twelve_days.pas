unit uISBNVerifier;

interface

type
  TIsbn = class
  private
    class function ClearISBN(const ANumber:string):string;
    class function CheckISBN(const ANumber:string):boolean;
  public
    class function IsValid(const AISBN:string):boolean;
  end;


implementation

uses
  System.SysUtils, System.StrUtils, System.RegularExpressions;


class function TIsbn.CheckISBN(const ANumber: string): boolean;
var
  i, res:integer;
  ch:char;
begin
  Result := False;
  if not TRegEx.IsMatch(ANumber, '^(\d{9}[\dX])$') then
    Exit;
  // Check character
  res := 0;
  for i := 1 to 10 do begin
    ch := ANumber[i];
    // special character only can be an X
    res := res + (StrToIntDef(string(ch), 10) * (11-i));
  end;
  Result := (res mod 11) = 0;
end;

class function TIsbn.ClearISBN(const ANumber: string): string;
begin
  Result := AnsiReplaceText(ANumber, '-', string.empty);
end;

class function TIsbn.IsValid(const AISBN: string): boolean;
var
  number:string;
begin
  number := ClearISBN(AISBN);
  Result := CheckISBN(number);
end;

end.