unit Meetup;

{$mode ObjFPC}{$H+}

interface

function meetup(
  const year, month : integer; const week, ADayOfWeek : string
) : string;

implementation

uses SysUtils;

type
  TWeek = (first, second, third, fourth, teenth, last);
  TDayOfWeek = (monday, tuesday, wednesday, thursday, friday, saturday, sunday);

function isLeapYear(year : integer): boolean;
begin
  result := (year mod 4 = 0) and ((year mod 100 <> 0) or (year mod 400 = 0));
end;

function daysInMonth(const year, month : integer) : integer;
begin
  case month of
    1: result := 31;
    2: result := 28 + ord(isLeapYear(year));
    3: result := 31;
    4: result := 30;
    5: result := 31;
    6: result := 30;
    7: result := 31;
    8: result := 31;
    9: result := 30;
    10: result := 31;
    11: result := 30;
    12: result := 31;
  else
    raise Exception.create('invalid month');
  end;
end;

function weekConcludes(year, month : integer; aweek : TWeek) : integer;
begin
  case aweek of
    first: result := 7;
    second: result := 14;
    third: result := 21;
    fourth: result := 28;
    teenth: result := 19;
    last: result := daysInMonth(year, month);
  end;
end;

function monthOffset(month : integer) : integer;
begin
  case month of
    1: result := 307; // offset from the end of February of previous year
    2: result := 338;
    3: result := 1;
    4: result := 32;
    5: result := 62;
    6: result := 93;
    7: result := 123;
    8: result := 154;
    9: result := 185;
    10: result := 215;
    11: result := 246;
    12: result := 276;
  else
    raise Exception.create('invalid month');
  end;
end;

function concludingDay(year, month, dayOfMonth : integer) : integer;
begin
  if month <= 2 then
    dec(year);

  result := (year + (year div 4) - (year div 100) + (year div 400) + monthOffset(month) + dayOfMonth) mod 7;
end;

function meetupDayOfMonth(year, month : integer; week : TWeek; dayOfWeek : TDayOfWeek) : integer;
var
  day : integer;
  concluding : integer;
  required : integer;
begin
  day := weekConcludes(year, month, week);
  concluding := concludingDay(year, month, day);
  required := ord(dayOfWeek);
  if concluding < required then
    inc(concluding, 7);

  result := day + required - concluding;
end;

function meetup(
  const year, month : integer; const week, ADayOfWeek : string
) : string;
var
  lWeek : TWeek;
  lDayOfWeek : TDayOfWeek;
  lDayOfMonth : integer;
begin
  case week of
    'first': lWeek := first;
    'second': lWeek := second;
    'third': lWeek := third;
    'fourth': lWeek := fourth;
    'teenth': lWeek := teenth;
    'last': lWeek := last;
  else
    raise Exception.create('invalid week');
  end;

  case ADayOfWeek of
    'Monday': lDayOfWeek := monday;
    'Tuesday': lDayOfWeek := tuesday;
    'Wednesday': lDayOfWeek := wednesday;
    'Thursday': lDayOfWeek := thursday;
    'Friday': lDayOfWeek := friday;
    'Saturday': lDayOfWeek := saturday;
    'Sunday': lDayOfWeek := sunday;
  else
    raise Exception.create('invalid day of week');
  end;

  lDayOfMonth := meetupDayOfMonth(year, month, lweek, lDayOfWeek);
  result := format('%.4D-%.2D-%.2D', [year, month, lDayOfMonth]);
end;

end.