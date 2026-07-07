unit uSieve;

interface

uses
  System.Generics.Collections;

type
  TSieve = class
    FNumber, FFirst:integer;
    FPrimes:TArray<integer>;

    // Create the initial arrayh
    function ArrayInicial: TArray<integer>;
    // detect is the process need to be stopped  (Power(index, 2)>ArrayTop )
    function EndProcess:boolean;
    // Mark multiples of a position
    procedure MarcarMultiplos;
    // detect if a position is marked  (Marked if value of position is NEGATIVE )
    function IsMarked(const ANumber:integer):boolean;
    // next Step of bucle
    procedure NextStep;
    // Array to return, without marked positions
    function ArrayFinal: TArray<integer>;
  public
    constructor Create(const ANumber: integer);
    class function Primes(const ANumber:integer):TArray<integer>;
  end;

const
  MARKED = -1;

implementation

uses
  System.SysUtils, Math;

function TSieve.ArrayFinal: TArray<integer>;
var
  i, j:integer;
begin
  Result := [];
  j := 1;
  for i := 0 to (Length(FPrimes)-1) do begin
    if not IsMarked(FPrimes[i]) then begin
      SetLength(Result, j);
      Result[j-1] := FPrimes[i];
      Inc(j);
    end;
  end;
end;

function TSieve.ArrayInicial: TArray<integer>;
var
  i:integer;
begin
  SetLength(Result, FNumber-1);
  for i := 1 to (FNumber-1) do
    Result[i-1] := i+1;
end;

constructor TSieve.Create(const ANumber: integer);
begin
  inherited Create;
  FNumber := ANumber;
  FFirst := 0;
  FPrimes := ArrayInicial;
end;

function TSieve.EndProcess: boolean;
begin
  Result := True;
  if Length(FPrimes)>1 then
    Result := (Power(FPrimes[FFirst], 2) > FNumber);
end;

function TSieve.IsMarked(const ANumber: integer): boolean;
begin
  Result := (ANumber < 0);
end;

procedure TSieve.MarcarMultiplos;
var
  i, j:integer;
begin
  for i := (FFirst) to FNumber-2 do begin
    j := Abs(FPrimes[FFirst] * FPrimes[i]);
    if (j <= FNumber) then
      if not IsMarked(FPrimes[j-2]) then
        FPrimes[j-2] := (FPrimes[j-2] * -1);
  end;
end;

procedure TSieve.NextStep;
begin
  Inc(FFirst);
end;

class function TSieve.Primes(const ANumber: integer): TArray<integer>;
var
  alg:TSieve;
begin
  Result := [];
  alg := TSieve.Create(ANumber);
  try
    while not alg.EndProcess do begin
      alg.MarcarMultiplos;
      alg.NextStep;
    end;
    Result := alg.ArrayFinal;
  finally
    FreeAndNil(alg)
  end;

end;

end.