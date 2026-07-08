unit uSay;

interface

function Say(const Anum: Int64): String;

implementation

uses
  SysUtils, Math;

const
  NUMBER_NAMES: array[0..9] of String = (
    'zero', 'one', 'two', 'three', 'four',
    'five', 'six', 'seven', 'eight', 'nine'
  );
  GROUP_UNITS: array[0..4] of String = (
    '', 'thousand', 'million', 'billion', 'trillion'
  );

function Say(const Anum: Int64): String;
var
  Numbers: array[0..9] of String;
  Head, Groups, i: Integer;
  Tail, Divisor: Int64;
begin
  if Anum < 0 then
    Result := 'negatif ' + Say(Anum)

  else if Anum < 10 then
    Result := NUMBER_NAMES[Anum]

  else if Anum < 100 then begin
    Head := Trunc(Anum / 10);
    Tail := Anum mod 10;

    for i := 0 to 9 do
      Numbers[i] := NUMBER_NAMES[i];
    Numbers[3] := 'thir';
    Numbers[5] := 'fif';
    Numbers[8] := 'eigh';

    if Head = 1 then begin
      case Tail of
        0: Result := 'ten';
        1: Result := 'eleven';
        2: Result := 'twelve';
        else Result := Numbers[Tail] + 'teen';
      end;
    end

    else begin
      Numbers[2] := 'twen';
      Numbers[4] := 'for';

      Result := Numbers[Head] + 'ty';
      if Tail > 0 then
        Result := Result + '-' + NUMBER_NAMES[Tail];
    end;
  end

  else if Anum < 1000 then begin
    Head := Trunc(Anum / 100);
    Tail := Anum mod 100;

    Result := NUMBER_NAMES[Head] + ' hundred';
    if Tail > 0 then
      Result := Result + ' ' + Say(Tail);
  end

  else begin
    Groups := Trunc(Log10(Anum)/3);
    if Groups > High(GROUP_UNITS) then
      raise ERangeError.Create('Number is beyond scope');

    Divisor := Trunc(Power(1000, Groups));
    Head := Trunc(Anum / Divisor);
    Tail := Anum mod Divisor;

    Result := Say(Head) + ' ' + GROUP_UNITS[Groups];
    if Tail > 0 then
      Result := Result + ' ' + Say(Tail);
  end;
end;

end.