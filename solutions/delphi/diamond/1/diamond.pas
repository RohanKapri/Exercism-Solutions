unit uDiamond;

interface

type
  TDiamond = class(TObject)
    class function Rows(aLetter: Char): TArray<String>;
  end;

implementation

uses StrUtils;

{ TDiamond }

class function TDiamond.Rows(aLetter: Char): TArray<String>;
var
  i, LetterIndex, LeftIndex, RightIndex, NbRows, NbCols: integer;
  Line: string;
  Character: Char;
begin
  LetterIndex := Ord(aLetter) - 64;
  LeftIndex := LetterIndex;
  RightIndex := LetterIndex;
  NbCols := LetterIndex * 2 - 1;
  NbRows := NbCols;
  SetLength(result, NbRows);
  // first part to center
  for i := 1 to LetterIndex do
  begin
    // initialize with spaces
    Line := StringOfChar(#32, NbCols);
    Character := Chr(64 + i);
    if (i > 1) then
    begin
      LeftIndex := LeftIndex - 1;
      RightIndex := RightIndex + 1;
    end;
    Line[LeftIndex] := Character;
    Line[RightIndex] := Character;
    result[i - 1] := Line;
  end;
  // last part
  for i := NbRows - 1 downto LetterIndex do
  begin
    result[i] := result[NbRows - (i + 1)];
  end;

end;

end.