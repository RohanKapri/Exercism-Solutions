unit uRotationalCipher;

interface

type
  RotationalCipher = class
  const
    ALPHABET = 'abcdefghijklmnopqrstuvwxyz';
  private
    class function CalculateNewCipherIndex(AIndex:integer):integer;
  public
    class function rotate(const AValue:string; const ANumber:Integer):string;
  end;
  
implementation

uses
  System.SysUtils, Winapi.Windows;

{ RotationalCipher }

class function RotationalCipher.CalculateNewCipherIndex(AIndex: integer): integer;
begin
  Result := AIndex;
  if (AIndex > 26) then
    Result := (AIndex MOD 27) + 1
  else if (AIndex < 1) then
    Result := AIndex + 26;
end;

class function RotationalCipher.rotate(const AValue: string; const ANumber: Integer): string;
var
  i, index, pos:integer;
  s:string;
begin
  Result := string.empty;
  for i := 1 to Length(AValue) do begin
    pos := AnsiPos(LowerCase(AValue[i]), ALPHABET);
    // Space and others chars not change in output
    if (pos = 0) then
      s := AValue[i]
    else begin
      // new index
      index := CalculateNewCipherIndex(pos + ANumber);
      // New char calculated
      s := ALPHABET[index];
      // Capital Letters
      if IsCharUpper(AValue[i]) then
        s := UpperCase(s);
    end;
    // generating the output
    Result := Result + s;
  end;
end;

end.