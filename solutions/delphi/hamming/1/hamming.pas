unit uHamming;

interface

type
  THamming = class
    class function Distance(const AChain1, AChain2:string):integer;
  end;

implementation

uses
  System.SysUtils;

{ THamming }

class function THamming.Distance(const AChain1, AChain2: string): integer;
var
  i: Integer;
begin
  if (AChain1=string.Empty) and (AChain2<>string.Empty) then
    raise EArgumentException.Create('error: left strand must not be empty');

  if (AChain2=string.Empty) and (AChain1<>string.Empty) then
    raise EArgumentException.Create('error: right strand must not be empty');

  if Length(AChain1) <> Length(AChain2) then
    raise EArgumentException.Create('error: left and right strands must be of equal length');

  Result := 0;
  for i := Low(AChain1) to High(AChain1) do
    if (AChain1[i] <> AChain2[i]) then
      Inc(Result);
end;

end.