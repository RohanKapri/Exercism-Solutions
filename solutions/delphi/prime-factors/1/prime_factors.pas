unit uPrimeFactors;

interface

type
  TPrimeFactors = class
    class function Factors(AValue:Int64): TArray<Int64>;
  end;

implementation

uses
  System.SysUtils, System.Generics.Collections;

{ TPrimeFactors }

class function TPrimeFactors.Factors(AValue: Int64): TArray<Int64>;
var
  l:TList<Int64>;
  i:Int64;
begin
  Result := [];
  l := TList<Int64>.Create;
  try
    while (AValue <> 1) do begin
      for i := 2 to AValue do begin
        if ((AValue mod i) = 0)  then begin
          l.Add(i);
          Break;    // not continue if founded
        end;
      end;
      AValue := AValue div i;
    end;
    Result := l.ToArray;
  finally
    FreeAndNil(l);
  end;
end;

end.