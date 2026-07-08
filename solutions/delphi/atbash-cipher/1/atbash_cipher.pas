unit uAtbashCipher;

interface

type
  TAtbashCipher = class
  const
    ALPHABET = 'abcdefghijklmnopqrstuvwxyz';
    NUMBERS = '0123456789';
  private
    class function EncodeDecode(AValue:string):string;
    class function AddSpaces(AValue:string):string;
  public
    class function Encode(AValue:string; op:integer=0):string;
    class function Decode(AValue:string):string;
  end;


implementation

uses
  System.Sysutils, System.StrUtils;

// same proc to Encode / Decode
class function TAtbashCipher.EncodeDecode(AValue:string):string;
var
  i, pos:integer;
  ch:char;
begin
  Result := string.Empty;
  // Prepare the input
  AValue := AValue.ToLower;
  AValue := AnsiReplaceText(AValue, ' ', '');

  for i := Low(AValue) to High(AValue) do begin
    // numbers => equal
    if (AnsiPos(AValue[i], NUMBERS) <> 0) then begin
      ch := AValue[i];
      Result := Result + ch;
    end
    // Letters => Translate
    else begin
      pos := AnsiPos(AValue[i], ALPHABET);
      if (pos <> 0) then begin
        ch := ALPHABET[Length(ALPHABET) - pos + 1];
        Result := Result + ch;
      end;
    end;
  end;
end;

// Add spaces (5 positions)
class function TAtbashCipher.AddSpaces(AValue: string): string;
var
  i:Integer;
begin
  for i := 0 to (Length(AValue) - 1) do begin
    if ((i MOD 5) = 0) and (i <> 0) then
      Result := Result + ' ';
    Result := Result + AValue[i+1];
  end;
end;

class function TAtbashCipher.Decode(AValue: string): string;
begin
  Result := EncodeDecode(AValue);
end;

class function TAtbashCipher.Encode(AValue:string; op:integer=0): string;
begin
  Result := AddSpaces(EncodeDecode(AValue));
end;

end.