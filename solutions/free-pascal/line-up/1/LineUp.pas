unit LineUp;
{$mode ObjFPC}{$H+}
interface
function FormatMessage(
  const name : ShortString; const number : byte
) : ShortString;
implementation
uses SysUtils;
function FormatMessage(
  const name : ShortString; const number : byte
) : ShortString;
  function suffix : ShortString;
  begin
    if number div 10 mod 10 = 1 then
      result := 'th'
    else
      case number mod 10 of
        1: result := 'st';
        2: result := 'nd';
        3: result := 'rd';
      else
        result := 'th';
      end;
  end;
begin
  result := format('%s, you are the %d%s customer we serve today. Thank you!',
                   [name, number, suffix]);
end;
end.