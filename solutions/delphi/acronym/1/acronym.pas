unit uAcronym;

interface

function abbreviate(const AValue:string):string;

implementation

uses
  System.SysUtils;

function abbreviate(const AValue:string):string;
const
  LETTERS = ['a' .. 'z', 'A' .. 'Z', '0'..'9', ''''];
var
  i:Integer;
  newWord:Boolean;
begin
  Result := '';
  newWord := True;
  for i := Low(AValue) to High(AValue) do
  begin
    if (newWord) and (AValue[i] in LETTERS) then
      Result := Result + UpperCase(AValue[i]);
    newWord := not (AValue[i] in LETTERS);
  end;
end;

end.