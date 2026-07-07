unit uBob;

interface

type
  TBob = class
  public
    class function Hey(Value: string): string;
  end;

implementation

uses
  System.RegularExpressions,
  System.StrUtils,
  System.SysUtils;

class function TBob.Hey(Value: string): string;
begin
  Value := Value.Trim;
  if TRegEx.IsMatch(Value, '[A-Z]') and not TRegEx.IsMatch(Value, '[a-z]') then
    Result := 'Whoa, chill out!'
  else if Value.EndsWith('?') then
    Result := 'Sure.'
  else if Value = '' then
    Result := 'Fine.  Be that way!'   
  else
    Result := 'Whatever.';
end;

end.