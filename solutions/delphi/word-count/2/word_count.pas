unit uWordCount;

interface

uses System.Generics.Collections;

type
  TWordCount = record
  private
    text: string;
  public
    function countWords: TDictionary<string, integer>;
  end;

function WordCount(const word: string): TWordCount;

implementation

uses System.SysUtils, System.RegularExpressions;

function WordCount(const word: string): TWordCount;
begin
  for var ch in word.Replace('\n', ' ') do
    if TRegEx.IsMatch(ch, '[A-Za-z0-9,\ '']') then
      result.text := result.text + ch;
end;

{ TWordCount }

function TWordCount.countWords: TDictionary<string, integer>;
var
  key: string;
begin
  result := TDictionary<string, integer>.Create;
  for var s in text.Split([',', ' ']) do
  begin
    if s = '' then
      continue;
    if (s.Chars[0] = '''') and (s.Chars[s.Length - 1] = '''') then
      key := Copy(LowerCase(s), 2, Length(s) - 2)
    else
      key := LowerCase(s);
    if result.ContainsKey(key) then
      result[key] := result[key] + 1
    else
      result.Add(key, 1);
  end;
end;

end.