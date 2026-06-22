unit FlowerField;

{$mode ObjFPC}{$H+}

interface

function annotate(const garden : string) : string;

implementation

uses Math, StrUtils, SysUtils;

function annotate(const garden : string) : string;
const
  newline: string = #10;
var
  inputLines : Array of string;
  rows : integer;
  columns : integer;
  r : integer;
  outputLine : string;
  c : integer;
  count : integer;
  r2 : integer;
  c2 : integer;
  outputLines : Array of string = ();
begin
  inputLines := SplitString(garden, newline);

  rows := Length(inputLines);
  if rows = 0 then
    exit(garden);

  columns := Length(inputLines[0]);
  if columns = 0 then
    exit(garden);

  for r := low(inputLines) to high(inputLines) do
    begin
      outputLine := '';
      for c := low(inputLines[r]) to high(inputLines[r]) do
        begin
          count := 0;
          for r2 := max(r - 1, low(inputLines)) to min(r + 1, high(inputLines)) do
            for c2 := max(c - 1, low(inputLines[r])) to min(c + 1, high(inputLines[r])) do
              if inputLines[r2][c2] = '*' then
                inc(count);

          if inputLines[r][c] = '*' then
            outputLine := outputLine + '*'
          else if count = 0 then
            outputLine := outputLine + ' '
          else
            outputLine := outputLine + chr(ord('0') + count);
        end;

      insert(outputLine, outputLines, Length(outputLines));
    end;

  result := string.Join(newline, outputLines);
end;

end.