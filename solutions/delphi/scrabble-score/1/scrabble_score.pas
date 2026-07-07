unit uScrabbleScore;

interface

type
  TLetterValue = record
    Value:Integer;
    Letters:string;
  end;

  TScrabble = class
  const
    LettersValues:array [1..7] of TLetterValue = (
      (Value:1;  Letters:'AEIOULNRST'),
      (Value:2;  Letters:'DG'),
      (Value:3;  Letters:'BCMP'),
      (Value:4;  Letters:'FHVWY'),
      (Value:5;  Letters:'K'),
      (Value:8;  Letters:'JX'),
      (Value:10; Letters:'QZ'));
    class function Score(const AValue:string):Integer;
  end;
  
  
implementation

uses
  System.SysUtils;

{ TScrabble }

class function TScrabble.Score(const AValue: string): Integer;
var
  i, j:Integer;
begin
  Result := 0;
  for i := 1 to (Length(AValue)) do
    for j := 1 to (Length(LettersValues)) do
      if (LettersValues[j].Letters.IndexOf(UpperCase(AValue[i])) <> -1) then
        Result := Result + LettersValues[j].Value;
end;

end.