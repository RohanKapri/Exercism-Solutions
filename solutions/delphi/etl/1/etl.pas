unit uEtl;

interface

uses System.Generics.Collections;

type
  TEtl = record
    function TransForm(data: TDictionary < integer, TList < string >> )
      : TDictionary<string, integer>;
  end;

var
  Etl: TEtl;

implementation

uses System.SysUtils;

{ TEtl }

function TEtl.TransForm(data: TDictionary < integer, TList < string >> )
  : TDictionary<string, integer>;
begin
  result := TDictionary<string, integer>.Create;
  for var d in data do
    for var item in d.Value do
      result.Add(item.ToLower, d.Key);
end;

end.