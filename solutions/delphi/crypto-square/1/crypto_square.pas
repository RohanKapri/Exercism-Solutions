unit uCryptoSquare;

interface

type
  TCryptoSquare = class
    class function ciphertext(const AMessage:string):string;
  end;


implementation

uses
  System.SysUtils, System.StrUtils;

// clear not valid symbokls
function Clear(const AMessage: string): string;
var
  i:integer;
begin
  Result := AMessage;
  for i := Length(Result) downto 1 do
    if not CharInSet(Result[i], ['0'..'9','A'..'Z','a'..'z']) then
      Delete(Result, i, 1)
end;

// Get rows of final message
function Rows(const AMessage: string): integer;
var
  d:double;
begin
  d := sqrt(Length(AMessage));
  Result := Trunc(d);
  if (d <> Result) then
    Result := Result + 1
end;

// Get cols of final message
function Cols(const AMessage: string): integer;
var
  d:double;
begin
  d := Length(AMessage) / Rows(AMessage);
  Result := Trunc(d);
  if (d <> Trunc(d)) then
    Result := Result +1 ;
end;

// fill with spaces necessaries
function Fill(const AMessage: string): string;
var
  cols, r:integer;
begin
  cols := Cols(AMessage);
  r := r(AMessage);
  Result := Copy(AMessage + DupeString(' ', cols), 0, (cols*r))
end;

// Encode the message
function Encode(const AMessage: string): string;
var
  r,c, cols, rows:integer;
begin
  cols := TCryptoSquare.Cols(AMessage);
  rows := TCryptoSquare.Rows(AMessage);
  Result := string.Empty;
  for r := 0 to rows-1 do begin
    for c := 0 to cols-1 do begin
      Result := Result + AMessage[(c * rows)+r +1];
    end;
    if (r <> (rows-1)) then
      Result := result + ' ';
  end;
end;


class function TCryptoSquare.ciphertext(const AMessage: string): string;
var
  s:string;
begin
  // clear not valid symbols of messages
  s := Clear(AMessage.ToLower);
  Result := s;
  if (Length(Result) < 3) then
    Exit;
  // fill space to message
  Result := TCryptoSquare.Fill(Result);
  // encode message
  Result := TCryptoSquare.Encode(Result);
end;


end.