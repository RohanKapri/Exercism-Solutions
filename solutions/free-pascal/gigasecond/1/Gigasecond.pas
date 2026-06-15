unit Gigasecond;
{$mode ObjFPC}{$H+}
interface
function add(const moment : string) : string;
implementation
uses DateUtils, StrUtils, SysUtils;
function add(const moment : string) : string;
var
  parts : Array Of String;
  datetime: TDateTime;
begin
  DefaultFormatSettings.ShortDateFormat := 'yyyy-mm-dd';
  DefaultFormatSettings.ShortTimeFormat := 'hh:nn:ss';
  DefaultFormatSettings.DateSeparator := '-';
  DefaultFormatSettings.TimeSeparator := ':';
  parts := SplitString(moment, 'T');
  datetime := StrToDate(parts[0]);
  if Length(parts) = 2 then
    datetime += StrToTime(parts[1]);
  datetime += 11574 + StrToTime('01:46:40');
  result := DateToStr(datetime) + 'T' + TimeToStr(datetime);
end;

end.