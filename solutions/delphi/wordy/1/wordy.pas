unit uWordy;

interface

uses System.Generics.Collections, System.SysUtils;

type
  EInvalidProblem = class(Exception);

  TTokenType = (ttAny, ttNumber, ttOperator);

  TState = (stBegin, stNumber, stOperator);

  TWordy = class
  private
    class var FOps : TList<string>;
    class function Recognize(AToken : string) : TTokenType;
    class function Strip(AToken: string) : integer;
    class function Calculate(AOpSt : string; AStack : TStack<integer>) : integer;
  public
    class function Answer(AInp : string) : integer;
  end;

implementation

uses System.RegularExpressions, System.Math;

{ TWordy }

class function TWordy.Answer(AInp: string): integer;
var Tokens : TArray<string>;
  W: string;
  Stack : TStack<integer>;
  OpSt : string;
  State : TState;
  tt : TTokenType;
begin

  Stack := TStack<integer>.Create;
  Tokens := AInp.Split([' ', '?', 'power'], ExcludeEmpty);
  state :=  stBegin;
  Result := -1;
  for W in Tokens do
  begin
    TT := Recognize(W);
    case state of
      stBegin:
        case tt of
          ttNumber: begin
            Stack.Push(Strip(W));
            State := stNumber;
          end;
          ttOperator: raise EInvalidProblem.Create('Missing operand before ' + W);
        end;
      stNumber:
        case tt of
          ttAny : raise EInvalidProblem.Create('Invalid Problem');
          ttNumber: raise EInvalidProblem.Create('Operator expected, but ' + W + ' found');
          ttOperator: begin
            OpSt := W;
            State := stOperator;
          end;
        end;
      stOperator:
        case tt of
          ttNumber: begin
            Stack.Push(Strip(W));
            Result := Calculate(OpSt,Stack);
            State := stNumber;
          end;
          ttOperator: raise EInvalidProblem.Create('Missing operand before ' + W);
        end;
    end;
  end;
  if State <> stNumber then raise EInvalidProblem.Create('Invalid Problem');
  Stack.Free;
end;

class function TWordy.Calculate(AOpSt : string; AStack : TStack<integer>): integer;
var a, b : integer;
begin
  a := AStack.Extract;
  b := AStack.Extract;
  result := -1;
  case TWordy.FOps.IndexOf(AOpSt) of
    0 : Result := b + a;
    1 : Result := b - a;
    2 : Result := b * a;
    3 : Result := b div a;
    4 : Result := trunc(Power(b, a));
  end;
  AStack.Push(Result);
end;

class function TWordy.Recognize(AToken: string): TTokenType;
begin
  Result := ttAny;
  if TRegEx.IsMatch(AToken,'(\d+)|(-\d+)|(\d+st$)|(\d+nd$)|(\d+rd$)|(\d+th$)') then
    Result := ttNumber;
  if TWordy.FOps.Contains(AToken) then
    Result := ttOperator;
end;

class function TWordy.Strip(AToken: string): integer;
begin
  Result := TRegEx.Replace(AToken,'[^-\d]', '', []).ToInteger;
end;

initialization

  TWordy.FOps := TList<string>.Create;
  TWordy.FOps.Add('plus');
  TWordy.FOps.Add('minus');
  TWordy.FOps.Add('multiplied');
  TWordy.FOps.Add('divided');
  TWordy.FOps.Add('raised');
  TWordy.FOps.Add('power');

finalization

  TWordy.FOps.Free;

end.