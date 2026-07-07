unit uPangram;

interface

function isPangram(ASentence: string): Boolean;

implementation

uses System.SysUtils, System.StrUtils, System.Generics.Collections;

function isPangram(ASentence: string): Boolean;
var
  LAlphabet, LPangram: string;
  LLetters: TArray<char>;
begin
  LAlphabet := 'abcdefghijklmnopqrstuvwxyz';
  LLetters := LAlphabet.ToCharArray;

  LPangram := ASentence.ToLower;

  if LPangram = '' then
    Result := false;

  for var i := 0 to Length(LLetters) - 1 do
  begin
    if not LPangram.Contains(LLetters[i]) then
    begin
      Result := false;
      Exit;
    end
  end;
  Result := true;
end;

end.