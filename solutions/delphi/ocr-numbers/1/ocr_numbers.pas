unit uOcrNumbers;

interface

type
  TDigitStr = string;

  TOcrNumbers = class
  // Representation numerical of all digits
  const
    VALUE_0 = 66272;
    VALUE_1 = 576;
    VALUE_2 = 66768;
    VALUE_3 = 67152;
    VALUE_4 = 1616;
    VALUE_5 = 67104;
    VALUE_6 = 67232;
    VALUE_7 = 592;
    VALUE_8 = 67296;
    VALUE_9 = 67168;
  private
    /// <summary> Convert any digit to an integer </summary>
    class function DigitToInteger(ADigit:string):integer;
    /// <summary> convert a constant of a digit to an string </summary>
    class function ValueToDigit(AValue:integer):string;
    /// <summary> Extract one digits from the initial array </summary>
    class function ExtractDigit(ARows: TArray<string>; row:integer; hHeight, vHeight:integer): string;
  public
    class function Convert(ARows:TArray<string>):string;
  end;

implementation

uses
  Vcl.Dialogs,
  System.SysUtils, System.StrUtils, System.Math;


class function TOcrNumbers.DigitToInteger(ADigit: string): integer;
var
  i:integer;
begin
  Result := 0;
  for i := 1 to Length(ADigit) do
    Result := Result + Trunc(Power(StrToInt(ADigit[i])*2, i));
end;


class function TOcrNumbers.ValueToDigit(AValue: integer): string;
begin
  case AValue of
    VALUE_0: Result := '0';
    VALUE_1: Result := '1';
    VALUE_2: Result := '2';
    VALUE_3: Result := '3';
    VALUE_4: Result := '4';
    VALUE_5: Result := '5';
    VALUE_6: Result := '6';
    VALUE_7: Result := '7';
    VALUE_8: Result := '8';
    VALUE_9: Result := '9';
    else     Result := '?'
  end;
end;

class function TOcrNumbers.ExtractDigit(ARows: TArray<string>; row:integer; hHeight, vHeight:integer): string;
var
  j:integer;
begin
  for j := 0 to 2 do
    if (Arows[row+vHeight][(j+1)+hHeight]='|') then
      Result := Result + '1'
    else if (Arows[row+vHeight][(j+1)+hHeight]='_') then
      Result := Result + '2'
    else
      Result := Result + '0';
end;

class function TOcrNumbers.Convert(ARows: TArray<string>): string;
var
  i:integer;
  ds:TDigitStr;
  hHayDigitos, vHayDigitos:boolean;
  hDigit, vDigit:integer;
begin
  // testing argument
  if ((Length(ARows) MOD 4) <> 0) then
    raise EArgumentException.Create('Number of input lines is not a multiple of four');

  // while for the digits in columns
  vDigit := 0;
  vHayDigitos := (vDigit < Length(ARows));
  while vHayDigitos do begin

    if (vDigit <> 0) then
      Result := Result + ',';

    // while for the digits in rown
    hDigit := 0;
    hHayDigitos := (hDigit < Length(ARows[1]));
    while hHayDigitos do begin
      // convert any digit to string like this:  000102000211
      ds := string.empty;
      for i := 0 to 3 do begin

        if ((Length(Arows[i]) MOD 3) <> 0) then
          raise EArgumentException.Create('Number of input columns is not a multiple of three');
        // Extract the Digit
        ds := ExtractDigit(ARows, i, hDigit, vDigit);
      end;

      hDigit := hDigit+3;
      hHayDigitos := (hDigit < Length(ARows[1]));

      // Convert StringDigit => integer => IntegerDigit
      Result := Result + ValueToDigit(DigitToInteger(ds));
    end;
    vDigit := vDigit+4;
    vHayDigitos := (vDigit < Length(ARows));
  end;
end;

end.