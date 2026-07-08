unit uMarkdown;

interface

type
  TMarkdown = class
    class function Parse(input: String): String;
  private
    class procedure Strong(var Line:string);
    class procedure Emphasized(var Line:string);
    class procedure Header(var Line :string);
    class procedure ItemList(var Line :string);
  end;

implementation

uses
  System.Sysutils, RegularExpressions;

class function TMarkdown.Parse(input: String): String;
var
  isNormalText: Boolean;
  isHeader: Boolean;
  Lines: TArray<String>;
  i: Integer;
  LiTrue: Boolean;
begin
  Lines := input.Split(['\n'], TStringSplitOptions.ExcludeEmpty);

  for i := Low(Lines) to High(Lines) do
  begin
    if (pos('__', Lines[i]) > 0) then
      Strong(Lines[i]);
    if (pos('_', Lines[i]) > 0) then
      Emphasized(Lines[i]);
    isHeader := (pos('#', Lines[i]) = 1);
    if (isHeader) then
    begin
      Header(Lines[i]);
      Result := Result + Lines[i];
    end;
    LiTrue := (pos('*', Lines[i]) = 1);
    if (LiTrue) then
    begin
      ItemList(Lines[i]);
      Result := Result + Lines[i];
    end;
    isNormalText := not LiTrue and not isHeader;
    if isNormalText then
      Result := Result + '<p>' + Lines[i] + '</p>';
  end;
  Result := TRegEx.Replace(Result, '<li>.*?<\/li>(?!<li>)', '<ul>$0</ul>');
end;

class procedure TMarkdown.Strong(var Line:string);
begin
  while TRegEx.IsMatch(Line, '\_\_(.)+\_\_') do
  begin
    Line := Line.Replace('__', '<strong>', []);
    Line := Line.Replace('__', '</strong>', []);
  end;
end;

class procedure TMarkdown.Emphasized(var Line: string);
begin
  while TRegEx.IsMatch(Line, '\_(.)+\_') do
  begin
    Line := Line.Replace('_', '<em>', []);
    Line := Line.Replace('_', '</em>', []);
  end;
end;

class procedure TMarkdown.Header(var Line:string);
var
  HeaderLevel: Integer;
  ch: Char;
begin
  HeaderLevel := 0;
  for ch in Line do
    if ch = '#' then
      inc(HeaderLevel)
    else
      break;
  Line := Format('<h%0:d>' + Line.Remove(0, HeaderLevel).TrimLeft + '</h%0:d>', [HeaderLevel]);
end;

class procedure TMarkdown.ItemList(var Line:string);
begin
  if Line.TrimLeft.StartsWith('*') then
  begin
    Line := Line.TrimLeft.Remove(0, 1);
    Line := '<li>' + Line.Trim + '</li>';
  end;
end;

end.