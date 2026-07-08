unit uMatrix;

interface

type
  TValue = Integer;
  TVector = TArray<TValue>;
  TVectors = TArray<TVector>; // A Matrix.

  TMatrix = class
  private
    Matrix: TVectors;
    function StrToMatrix(MatrixStr: string): TVectors;
  public
    function Column(Index: Integer): TVector;
    function Row(Index: Integer): TVector;
    constructor Create(MatrixStr: string); overload;
  end;

implementation

uses
  Character, SysUtils;

{ TMatrix }

function TMatrix.Column(Index: Integer): TVector;
var
  i: Integer;
begin
  Result := [];
  for i := Low(Matrix) to High(Matrix) do begin
    Result := Result + [Matrix[i][Index - 1]];
  end;
end;

function TMatrix.Row(Index: Integer): TVector;
begin
  Result := Matrix[Index - 1];
end;

function TMatrix.StrToMatrix(MatrixStr: string): TVectors;

  function IsEscapeChar(Chr: Char): Boolean;
  const
    cEscapeCharacter = '\';
  begin
    Result := Chr = cEscapeCharacter;
  end;

var
  Chr: Char;
  DigitStr: string;
  Vector: TVector;
begin
  Result := [];
  Vector := [];
  DigitStr := '';

  for Chr in MatrixStr do begin

    if Chr.IsDigit then begin
      // Concatenate subsequent digits
      DigitStr := DigitStr + Chr;

    end else if Chr.IsWhiteSpace then begin
      // Whitespace seperates values
      Vector := Vector + [StrToInt(DigitStr)];
      DigitStr := '';

    end else if IsEscapeChar(Chr) then begin
      // EscapeChar seperates intraline rows
      Vector := Vector + [StrToInt(DigitStr)];
      Result := Result + [Vector];
      Vector := [];
      DigitStr := '';
    end;
  end;

  // Add the final row
  Vector := Vector + [StrToInt(DigitStr)];
  Result := Result + [Vector];
end;

constructor TMatrix.Create(MatrixStr: string);
begin
  Matrix := StrToMatrix(MatrixStr);
end;

end.