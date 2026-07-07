unit uPhoneNumber;

interface

type
  IPhoneNumber = interface
    function clean:string;
    function Area:string;
    function Exchange:string;
    function ToString:string;
  end;

  TPhoneNumber = class
  private
    FPhoneNumber: string;
    /// <summary> Only the numbers of the string </summary>
    function OnlyNumbers:string;
    /// <summary>  Las 4 numbers </summary>
    function Number:string;

    property PhoneNumber:string read FPhoneNumber write FPhoneNumber;
  public
    /// <summary> clean correct phone Number or empty </summary>
    function clean:string;
    /// <summary> the first 3 characters </summary>
    function Area:string;
    /// <summary> the 3 characters of the center </summary>
    function Exchange:string;
    function ToString:string; override;
  end;

const
  VALID_NUMBERS = ['0'..'9'];
  VALID_N_DIGITS = ['2'..'9'];
  COUNTRY_CODE = '1';

function NewPhoneNumber(const APhoneNumber:string):TPhoneNumber;

implementation

uses
  System.Sysutils;

function NewPhoneNumber(const APhoneNumber:string):TPhoneNumber;
begin
  Result := TPhoneNumber.Create;
  Result.PhoneNumber := APhoneNumber;
end;

{ IPhoneNumber }

function TPhoneNumber.Area: string;
begin
  Result := clean;
  if (Result <> string.Empty) then
    Result := Copy(Result, 1, 3)
end;

function TPhoneNumber.clean: string;
var
  isCorrect:boolean;
begin
  Result := OnlyNumbers;
  isCorrect := false;

  if (Length(Result) = 10) then begin
    isCorrect := CharInSet(Result[1], VALID_N_DIGITS) and
                 CharInSet(Result[4], VALID_N_DIGITS);
  end
  else if (Length(Result) = 11) then begin
    isCorrect := CharInSet(Result[2], VALID_N_DIGITS) and
                 CharInSet(Result[5], VALID_N_DIGITS) and
                 (Result[1] = COUNTRY_CODE);
    Result := copy(Result, 2, Length(Result));
  end;

  if not iscorrect then
    Result := string.empty;

end;

function TPhoneNumber.Number:string;
begin
  Result := clean;
  if (Result <> string.Empty) then
    Result := Copy(Result, 7, 4)
end;

function TPhoneNumber.Exchange: string;
begin
  Result := clean;
  if (Result <> string.Empty) then
    Result := Copy(Result, 4, 3)
end;

function TPhoneNumber.OnlyNumbers: string;
var
  i:integer;
begin
  Result := string.Empty;
  for i := 0 to (Length(PhoneNumber)) do
    if CharInSet(PhoneNumber[i], VALID_NUMBERS) then
      Result := result + PhoneNumber[i];
end;

function TPhoneNumber.ToString: string;
begin
  Result := clean;
  if (Result <> string.Empty) then     // Correct format (223) 456-7890'
    Result := '(' + Area + ') ' + Exchange + '-' + Number;
end;

end.