unit PigLatin;

{$mode ObjFPC}{$H+}

interface

function translate(const phrase : string) : string;

implementation

uses SysUtils;

function translateWord(const word : string) : string;
var
  startIndex : integer;
  midIndex : integer;
  ch : char;
  prev : char;
begin
  startIndex := 1;
  midIndex := startIndex;
  ch := word[startIndex];
  if  (startIndex + 1 <= length(word)) and
      (ch <> 'a') and
      (ch <> 'e') and
      (ch <> 'i') and
      (ch <> 'o') and
      (ch <> 'u') and
      ((ch <> 'x') or (word[startIndex + 1] <> 'r')) and
      ((ch <> 'y') or (word[startIndex + 1] <> 't')) then
    begin
      prev := ch;
      inc(midIndex);
      ch := word[midIndex];
      while (midIndex <= length(word)) and
            (ch <> 'a') and
            (ch <> 'e') and
            (ch <> 'i') and
            (ch <> 'o') and
            (ch <> 'u') and
            (ch <> 'y') do
        begin
          prev := ch;
          inc(midIndex);
          if midIndex <= length(word) then
            ch := word[midIndex]
          else
            ch := ' ';
        end;
      if (prev = 'q') and (ch = 'u') then
        inc(midIndex);
    end;

  result := copy(word, midIndex, length(word) + 1 - midIndex) + copy(word, startIndex, midIndex - 1) + 'ay';
end;

function translate(const phrase : string) : string;
var
  start : integer;
  finish : integer;
begin
  result := '';
  start := 1;
  while start <= length(phrase) do
    begin
      finish := start + 1;
      while (finish <= length(phrase)) and (phrase[finish] <> ' ') do
        inc(finish);

      if start > 1 then
        result := result + ' ';

      result := result + translateWord(copy(phrase, start, finish - start));
      start := finish + 1;
    end;
end;

end.